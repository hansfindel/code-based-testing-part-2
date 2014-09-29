class Robot < ActiveRecord::Base
    include AutoPresentable 

    belongs_to :code_name 

    has_many :robot_weapons, inverse_of: :robot
    has_many :weapons, through: :robot_weapons

    has_one :health, as: :machine

    validates :code_name, presence: true #, message: "Needs to be a registered robot"
    validates :health, presence: true #, message: "Needs to be initialized with a health status"
    validate :initial_health_by_default, on: :create
    validate :current_health_by_default, on: :create

    accepts_nested_attributes_for :robot_weapons
    accepts_nested_attributes_for :code_name

    delegate :damage, to: :code_name
    delegate :name, to: :code_name

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
        #Have to calculate weapons to be used
        to_be_used = []

        #It consideres that the robot always use its basal power
        max_damage = self.damage

        to_be_used.each do |weapon|
            max_damage += weapon.damage if weapon_instance.stable?
            weapon.recoil_effect
        end

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

    private

    def initial_health_by_default
        default_health = self.code_name.max_health
        if self.health.maximum != default_health
            errors.add(:health, 'Invalid health, maximum health must have default value')
        end
    end

    def current_health_by_default
        default_health = self.code_name.max_health
        if self.health.current != default_health
            errors.add(:health, 'Invalid health, current health must have default value')
        end
    end


    def use_weapon(weapon, target)
        weapon.attack(target)
        weapon.recoil_effect
    end

end
