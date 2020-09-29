require_relative '../workers/calculate_worker.rb'

class App < Sinatra::Base
  get '/' do
    json(text: 'Hello world!')
  end

  get '/add' do
    ::Hello::Workers::CalculateWorker.perform_async
    json(status: 200)
  end
end
