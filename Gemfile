source 'https://rubygems.org'

#              ___
#      o O O  / __|    ___      _ _    ___
#     o      | (__    / _ \    | '_|  / -_)
#    TS__[O]  \___|   \___/   _|_|_   \___|
#   {======|_|"""""|_|"""""|_|"""""|_|"""""|
#  ./o--000'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'

gem 'rack'
gem 'sinatra'
gem 'puma', '~> 4.0'
gem 'dotenv'
gem 'sinatra-contrib'
gem 'sidekiq'
gem 'rollbar'

# dry-rb
gem 'dry-struct', '~> 1.3'
gem 'dry-initializer', '~> 3.0'
gem 'dry-monads', '~> 1.3'

# aws
gem 'aws-sdk-ec2', '~> 1'
gem 'aws-sdk-elasticloadbalancing', '~> 1'
gem 'aws-sdk-ec2instanceconnect', '~> 1'

#              ___                              _              _ __                            _
#      o O O  |   \    ___    __ __    ___     | |     ___    | '_ \  _ __     ___    _ _     | |_
#     o       | |) |  / -_)   \ V /   / -_)    | |    / _ \   | .__/ | '  \   / -_)  | ' \    |  _|
#    TS__[O]  |___/   \___|   _\_/_   \___|   _|_|_   \___/   |_|__  |_|_|_|  \___|  |_||_|   _\__|
#   {======|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|_|"""""|
#  ./o--000'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'
#
group :development, :test do
  # debug
  gem 'byebug'

  # rubocop
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-performance', require: false

  # rspec
  gem 'rspec'
end

group :development do
  # reloader
  gem 'rerun'

  # capistrano
  gem 'capistrano', '~> 3.6', require: false
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler', '~> 2.0'
  gem 'capistrano3-puma', github: 'seuros/capistrano-puma'
  gem 'capistrano-sidekiq', git: 'https://github.com/rwojnarowski/capistrano-sidekiq.git'
  gem 'slackistrano'

  # rspec
  gem 'rspec'
end
