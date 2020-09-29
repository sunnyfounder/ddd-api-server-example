require 'dotenv/tasks'
require 'aws-sdk-ec2'
require 'aws-sdk-ec2instanceconnect'

desc 'AWS Access'
namespace :aws do
  task :access do
    begin
      environment = select_prompt :environment, options: ['staging', 'production', 'analytics', 'api-staging']
      function = select_prompt :function, options: ['web', 'shadow', 'api']

      ec2 = Aws::EC2::Resource.new
      filters = []
      filters.push(name: 'instance-state-name', values: ['running'])
      filters.push(name: 'tag:Environment', values: [environment])
      filters.push(name: 'tag:Function', values: [function])

      instances = ec2.instances(filters: filters).map do |instance|
        {
          name: instance.tags.find { |hash| hash[:key] == 'Name' }[:value],
          public_ip: instance.public_ip_address,
          availability_zone: instance.placement.availability_zone,
          instance_id: instance.instance_id
        }
      end

      instance =
        if instances.count == 0
          raise 'Server not running'
        elsif instances.count == 1
          instances[0]
        else
          instance_name = select_prompt :ec2_server, options: instances.pluck(:name)
          instances.find { |hash| hash[:name] == instance_name }
        end

      identity = select_prompt :identity, options: ['apps', 'ubuntu']
      public_key = retrieve_public_key
      ec2_connect_client = Aws::EC2InstanceConnect::Client.new
      ec2_connect_client.send_ssh_public_key(
        instance_os_user: identity,
        instance_id: instance[:instance_id],
        availability_zone: instance[:availability_zone],
        ssh_public_key: public_key
      )

      auto_connect = prompt :auto_connect, default: 'y'
      system "ssh #{identity}@#{instance[:public_ip]}" if auto_connect == 'y'
    rescue StandardError => e
      puts e.inspect
    end
  end
end

def retrieve_public_key
  default_location = "#{ENV['HOME']}/.ssh/id_rsa.pub"
  location = prompt :public_key_location, default: default_location
  File.read(location)
end

def select_prompt(item, options:, default: 0)
  puts("Select #{item}?")
  options.each_with_index do |val, i|
    puts("  [#{i}] #{val}")
  end

  prompt_string = '  Please enter'
  prompt_string += " (#{default})" if default
  print(prompt_string + ': ')
  response = STDIN.gets.chomp
  print("\n")

  options[response.to_i || default]
end

def prompt(item, default:)
  prompt_string = "Please enter #{item}"
  prompt_string += " (#{default})" if default
  print(prompt_string + ': ')
  response = STDIN.gets.chomp

  response.strip.empty? ? default : response
end
