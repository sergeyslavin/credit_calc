require 'sinatra'
# require 'sinatra/reloader' if development?
require 'json'
require './lib/calculator'

set :views, 'views'
set :public_folder, 'assets'

get '/' do
	haml :index
end

post '/calc' do

	content_type :json

	if params[:total_amount].empty? or params[:period_number].empty? or params[:percent].empty?
		return { status: 400, message: "Please, check input data!", data: nil }.to_json
	end

	total_amount = params[:total_amount].to_f
	period_number = params[:period_number].to_i
	percent = params[:percent].to_f
	type = params[:calc_type]



	calc = Calculator.new

	calc.credit { |e|
		e.set_credit_percent = percent
		e.set_credit_sum = total_amount
		e.set_credit_term = period_number
		e.type = type
	}

	result = calc.result
	p result

	unless result.nil?
		{status: 200, message: "Success!", data: result, method_type: type}.to_json
	else
		{status: 400, message: "Error!", data: nil}.to_json
	end

end
