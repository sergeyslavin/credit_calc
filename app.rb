require 'sinatra'
require 'sinatra/reloader' if development?
require 'json'
require './lib/calculator'

set :views, 'views'
set :public_folder, 'assets'

get '/' do
	haml :index
end

post '/calc' do
	
	content_type :json

	total_amount = params[:total_amount]
	period_number = params[:period_number]
	percent = params[:percent]
	type = params[:calc_type]

	if total_amount.empty? or period_number.empty? or percent.empty?
		return {status: 400, message: "Please, check input data!", data: nil}.to_json
	end

	calc = Calculator.new
	
	calc.credit { |e|
		e.set_credit_percent = percent
		e.set_credit_sum = total_amount
		e.set_credit_term = period_number
		e.type = type
	}

	result = calc.result

	unless result.nil?
		{status: 200, message: "Success!", data: result}.to_json
	else
		{status: 400, message: "Error!", data: nil}.to_json
	end

end