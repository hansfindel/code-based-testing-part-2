class Fighter < ActiveRecord::Base

	has_one :human, as: :person 
    delegate :name, to: :human
	

	def calculate_damage(args)
        # doesn't need to be the highest one
        self.streng*self.speed + self.ki*self.combo
    end
end
