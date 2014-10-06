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

    delegate :damage, to: :code_name
    delegate :name, to: :code_name

    # resetea la velocidad de ataque después de atacar
    def reset_velocity
      self.attack_velocity = self.max_attack_velocity
    end
    def alive?
        remaining_health > 0
    end

    def remaining_health
        self.health.current
    end

    def take_damage damage 
        # should not get lower than 0
        updated_health = health.current - damage
        updated_health >= 0 ? health.current = updated_health : health.current = 0
        if updated_health >= 0
          self.health.current = updated_health
        else
          self.health.current = 0
        end
      self.save
    end

    def calculate_damage(total_health=1)
        # doesn't need to be the highest one
        max_damage = self.damage
        best_weapon = nil
        robot_weapons.each do |weapon|
          if valid_and_heavier_weapon?(max_damage, weapon)
            max_damage = weapon.damage
            best_weapon = weapon
          end
        end
        best_weapon.take_damage if best_weapon # 1 por defecto
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
