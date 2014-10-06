class Robot < ActiveRecord::Base
    include AutoPresentable 

    belongs_to :code_name 

    has_many :robot_weapons
    has_many :weapons,-> { order 'damage ASC' }, through: :robot_weapons

    has_one :health, as: :machine 

    validates :code_name, presence: true #, message: "Needs to be a registered robot"
    validates :health, presence: true #, message: "Needs to be initialized with a health status"
    accepts_nested_attributes_for :health
    accepts_nested_attributes_for :robot_weapons
    before_save :validate_attack_speed
    delegate :damage, to: :code_name
    delegate :name, to: :code_name

    def alive?
        remaining_health > 0
    end
    def validate_attack_speed
        if self.attack_speed < 0
            self.attack_speed = 0
        end
    end
    def remaining_health
        self.health.current
    end

    def take_damage damage 
        # should not get lower than 0
        self.health.current -= damage
    end

    def calculate_damage(remaining_health=1)
        max_damage = self.damage
        robot_weapons.each do |weapon|
            max_damage = weapon.damage if valid_and_heavier_weapon?(max_damage, weapon)
            break if max_damage >= remaining_health
        end
        if ["T-1000","T-X"].include? self.code_name.to_s
            recharge
        end
        self.update_attribute(:attack_speed,rand(1..3))
        max_damage
    end

    def recharge
        self.health.recharge
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
