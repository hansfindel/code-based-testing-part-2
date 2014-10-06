class TimeTraveller < ActiveRecord::Base
	has_many :time_traveller_weapons
	has_many :weapons, through: :time_traveller_weapons

    has_one :health, as: :healthy 

    validates :name, presence: true #, message: "Needs to be a registered human"
    validates :health, presence: true #, message: "Needs to be initialized with a health status"

    accepts_nested_attributes_for :health
    accepts_nested_attributes_for :time_traveller_weapons

    def alive?
        remaining_health > 0
    end

    def remaining_health
        self.health.current
    end

    def take_damage damage 
        # should not get lower than 0
        self.health.current -= damage
    end

    def calculate_damage(total_health=1)
        # doesn't need to be the highest one
        max_damage = self.damage
        max_recoil = 0
        time_traveller_weapons.each do |weapon|
            if valid_and_heavier_weapon?(max_damage, weapon)
                max_damage = weapon.damage
                max_recoil = weapon.recoil
            end
        end
        #Takes damage from weapons recoil
        take_damage max_recoil
        max_damage
    end

    def valid_and_heavier_weapon?(max_damage, weapon_instance)
        weapon_instance.stable? and max_damage < weapon_instance.damage
    end

    # pending test - then change it to work with an array instead of a hash
    def get_instance_state_message
        @status ||= 0
        @status %= 4
        {
            "0" => "H", 
            "1" => "O",  
            "2" => "L", 
            "3" => "A"
        }[ ((@status+=1)-1).to_s ]
    end
end
