class Calculator

	attr_accessor :total_amount, :period_number, :percent

	def self.calc
		raise 'Block should be given' unless block_given?
		instance = Calculator.new
		yield instance
		instance
	end

	def result
		p self.total_amount
	end

end

calc = Calculator.calc do |e|
	e.total_amount = 12
	e.period_number = 4
	e.percent = 10	
end

calc.result