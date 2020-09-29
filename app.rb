require 'dotenv'
require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/namespace'
require 'rollbar/middleware/sinatra'

Dotenv.load
# load all extension initilizers
require_relative 'config/initializers/init'
# load all controllers
require_relative 'domains/controllers_init'

class App < Sinatra::Base
  use Rollbar::Middleware::Sinatra

  configure do
    set :server, :puma
  end

  configure :development do
    set :protection, except: [:json_csrf]
  end

  configure :production do
    set :raise_errors, false
    set :show_exception, false
  end

  before do
    content_type :json
    # headers 'Access-Control-Allow-Origin' => 'https://airtable.com/',
    #         'Access-Control-Allow-Methods' => %w[GET]
  end
end
