require 'rollbar'

DEVELOP_ENV = ['development', 'test'].freeze

Rollbar.configure do |config|
  config.enabled = false if DEVELOP_ENV.include? ENV['APP_ENV']
  config.access_token = ENV['ROLLBAR_TOKEN']
  config.environment = ENV['APP_ENV']
end
