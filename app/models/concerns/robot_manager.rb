module RobotManager
	extend ActiveSupport::Concern
	included do 
		puts "robot concer"
		# has_many ...
	end

	def salute2
		puts "Robot Manager: Hi, I am a #{self.class.to_s}. My name is #{name}"
	end

end