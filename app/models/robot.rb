class Robot < ActiveRecord::Base
    include AutoPresentable 

    belongs_to :code_name 

    has_many :robot_weapons
    has_many :weapons, through: :robot_weapons

    has_one :health, as: :machine 

    before_validation :default_values

    validates :code_name, presence: true #, message: "Needs to be a registered robot"
    validates :health, presence: true #, message: "Needs to be initialized with a health status"
    

    accepts_nested_attributes_for :health
    accepts_nested_attributes_for :robot_weapons

    delegate :damage, to: :code_name
    delegate :name, to: :code_name

    def default_values
        self.health ||= Health.assing_health(default_health)
        self.frozen_count ||= 0
    end

    def alive?
        remaining_health > 0
    end

    def default_health
        if self.code_name and self.code_name.health
            self.code_name.health
        else
            5
        end
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
        recoil = 0
        freeze = false
        robot_weapons.each do |weapon|
            if valid_and_heavier_weapon?(max_damage, weapon)
                max_damage = weapon.damage
                freeze = weapon.freezer
                if weapon.recoil
                    recoil = weapon.recoil
                end
            end
        end
        return [max_damage, recoil, freeze]
    end

    def attack(contender2)
        if self.frozen_count == 0
            attack_values = self.calculate_damage
            self.take_damage attack_values[1]
            contender2.take_damage attack_values[0]
            contender2.calculate_freeze attack_values[2]
        else
            self.frozen_count -= 1
        end
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

    def calculate_freeze(value)
        if value
            self.frozen_count += 1
        end
    end

end
