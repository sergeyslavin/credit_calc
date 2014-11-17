require 'sinatra'
require 'sinatra/reloader' if development?

set :views, 'views'
set :public_folder, 'assets'

get '/' do
	haml :index
end

post '/calc' do

end