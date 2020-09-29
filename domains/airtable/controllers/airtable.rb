class App < Sinatra::Base
  register Sinatra::Namespace
  namespace '/airtable' do
    get '/' do
      json(text: 'Welcome to airtable!')
    end
  end
end
