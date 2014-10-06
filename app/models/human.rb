class Human < ActiveRecord::Base

	has_one :health, as: :being 
    
	belongs_to  :person, :polymorphic => true

    validates :health, presence: true #, message: "Needs to be initialized with a health status"

    accepts_nested_attributes_for :health

    
    def alive?
        remaining_health > 0
    end

    def remaining_health
        self.health.current
    end

    def take_damage damage 
        # should not get lower than 0
        self.health.take_damage damage
    end

    def calculate_damage(args)
        # doesn't need to be the highest one
        1
    end


end
