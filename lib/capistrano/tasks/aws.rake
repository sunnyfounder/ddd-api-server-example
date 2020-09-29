require 'aws-sdk-ec2'
require 'aws-sdk-ec2instanceconnect'

namespace :aws do
  task :setup do
    invoke 'aws:access'
    invoke 'aws:retrieve_server'
  end

  task :access do
    default_location = "#{ENV['HOME']}/.ssh/id_rsa.pub"
    ask :public_key_location, default_location
    public_key = File.read(fetch(:public_key_location))

    ec2_connect_client = Aws::EC2InstanceConnect::Client.new
    ec2_instances.each do |instance|
      ec2_connect_client.send_ssh_public_key(
        instance_os_user: 'apps',
        instance_id: instance.instance_id,
        availability_zone: instance.placement.availability_zone,
        ssh_public_key: public_key
      )
    end
  end

  task :retrieve_server do
    servers = ec2_instances(function: 'api').map(&:public_ip_address)
    set :servers, servers
  end
end

def ec2_instances(function: nil)
  ec2 = Aws::EC2::Resource.new

  filters = []
  filters.push(name: 'instance-state-name', values: ['running'])
  filters.push(name: 'tag:Environment', values: ['api-staging'])
  filters.push(name: 'tag:Function', values: [function]) if function

  ec2.instances(filters: filters)
end
