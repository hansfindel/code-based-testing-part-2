class Robot < ActiveRecord::Base
    include AutoPresentable 

    belongs_to :code_name 

    has_many :robot_weapons
    has_many :weapons, through: :robot_weapons

    has_one :health, as: :machine 

    validates :code_name, presence: true #, message: "Needs to be a registered robot"
    validates :health, presence: true #, message: "Needs to be initialized with a health status"

    accepts_nested_attributes_for :health
    accepts_nested_attributes_for :robot_weapons
    accepts_nested_attributes_for :code_name, :reject_if => :all_blank, :allow_destroy => true

    delegate :damage,:technology, to: :code_name

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
        max_damage_weapon = nil
        robot_weapons.each do |weapon|
            max_damage = weapon.damage if valid_and_heavier_and_technology_weapon?(max_damage, weapon)
            max_damage_weapon = weapon
        end
        max_damage_weapon.use if max_damage_weapon
        max_damage
    end

    def regenerate
        new_health = remaining_health*1.01
        self.health.current = [new_health, self.health.maximum].min
    end

    def valid_and_heavier_and_technology_weapon?(max_damage, weapon_instance)
        weapon_instance.stable? and max_damage < weapon_instance.damage and weapon_instance.weapon.technology <= technology
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
