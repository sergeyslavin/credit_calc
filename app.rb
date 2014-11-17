require 'sinatra'
require 'sinatra/reloader' if development?
require 'json'

set :views, 'views'
set :public_folder, 'assets'

get '/' do
	haml :index
end

post '/calc' do
	content_type :json
	{status: 200, message:"Success"}.to_json
end