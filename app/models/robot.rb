class Robot < ActiveRecord::Base
    include AutoPresentable
    REGENERATING_ATTACK_PERCENTAGE=0.1
    NANITE_DAMAGE_AMOUNT=10

    belongs_to :code_name 

    has_many :robot_weapons
    has_many :weapons, through: :robot_weapons

    has_one :health, as: :machine

    validates :code_name, presence: true #, message: "Needs to be a registered robot"
    validates :health, presence: true #, message: "Needs to be initialized with a health status"
    validates :nanites, :numericality => { :greater_than_or_equal_to => 0 }

    accepts_nested_attributes_for :health
    accepts_nested_attributes_for :robot_weapons

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
        # doesn't need to be the highest one
        max_damage = self.damage
        robot_weapons.each do |weapon|
            max_damage = weapon.damage if valid_and_heavier_weapon?(max_damage, weapon)
        end
        max_damage
    end

    def valid_and_heavier_weapon?(max_damage, weapon_instance)
        weapon_instance.stable? and max_damage < weapon_instance.damage
    end

    def regenerate_after_attack
      if regenerating_attack
        self.health.current += REGENERATING_ATTACK_PERCENTAGE*self.health.maximum
      end
    end

    def take_nanite_damage
      if self.nanites>0
        self.health.current -= NANITE_DAMAGE_AMOUNT*self.nanites
      end
    end

    def add_nanites(nanites=1)
      self.nanites+=nanites
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
