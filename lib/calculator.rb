class Float
	def round_and_truncate
		(self * 100).round / 100.0
	end
end

class Calculator
	
	attr_accessor :credit_percent, :credit_sum, :credit_term

	def initializer
		self.credit_percent = 0.0
		self.credit_sum = 0.0
		self.credit_term = 0.0
	end

	def type=(type)
		raise "Type should be 'differentiated' or 'annuity'" unless self.include_type? type
		@type = type
	end

	def type
		@type
	end

	def include_type?(type)
		(["differentiated", "annuity"].include? type)
	end

	def credit
		raise 'Block should be given' unless block_given?
		yield self
	end

	def result
		raise 'Please, specify type before!' if self.type.nil?

		if type.eql? "differentiated"
			self.differentiated
		else
			self.annuity
		end
	end

	def annuity
		table_of_result_value = []

		rest_of_credit_sum = self.credit_sum
		
		1.upto(self.credit_term.to_i) do |month|

			percent = ((self.credit_percent / 12) / 100)

			accrued_percent = self.credit_percent / 100.0

			accrued_interest = rest_of_credit_sum / self.credit_term * accrued_percent	

			main_debt = self.credit_sum * percent / (1 - 1 / (1 + percent) ** self.credit_term)
			
			payment_sum = main_debt - accrued_interest

			rest_of_credit_sum -= payment_sum

			table_of_result_value << { payment: payment_sum.round_and_truncate, 
												percent: accrued_interest.round_and_truncate,
												rest: rest_of_credit_sum.round_and_truncate,
												main_debt: main_debt.round_and_truncate,
												month: month }
		end

		table_of_result_value
	end

	def differentiated

		table_of_result_value = []

		rest_of_credit_sum = self.credit_sum

		1.upto(self.credit_term.to_i) do |month|

			percent = self.credit_percent / 100.0

			main_debt = self.credit_sum / self.credit_term

			accrued_interest = rest_of_credit_sum / self.credit_term * percent

			rest_of_credit_sum += accrued_interest

			payment_sum = main_debt + accrued_interest

			rest_of_credit_sum -= payment_sum

			table_of_result_value << { payment: payment_sum.round_and_truncate, 
												percent: accrued_interest.round_and_truncate,
												rest: rest_of_credit_sum.round_and_truncate,
												main_debt: main_debt.round_and_truncate,
												month: month }
		end

		table_of_result_value
	end

	def method_missing(method_name, *args, &block)
		if method_name =~ /^set_(.+)$/
			self.set($1, args[0])
		else
			super
		end
	end

	def set(attr_name, value)
		if self.respond_to? attr_name
			self.send("#{attr_name}", value.to_f)
		end
	end
end

# calc = Calculator.new

# calc.credit do |e|
# 	e.set_credit_percent = 20
# 	e.set_credit_sum = 1000
# 	e.set_credit_term = 12
# 	e.type = "annuity"
# end