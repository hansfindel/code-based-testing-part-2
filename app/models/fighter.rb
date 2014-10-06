class Fighter < ActiveRecord::Base

	has_one :human, as: :person

    delegate :name, to: :human
    delegate :alive?, to: :human
    delegate :remaining_health, to: :human
    delegate :take_damage, to: :human

    accepts_nested_attributes_for :human

	def calculate_damage(args = {})
    	# doesn't need to be the highest one
    	self.strengh*self.speed + self.ki*self.combo_rate
    end 
end
