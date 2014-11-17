class Calculator
	def self.calc(&block)
		Calculator.new(&block)
	end

	def initializer(&block)
		instance_eval block
	end
end