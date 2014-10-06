module AutoPresentable
	extend ActiveSupport::Concern
	included do 
		puts "hi"
		# has_many ...
	end

	def salute
		puts "Hi, I am a #{self.class.to_s}. My name is #{name}"
	end

end