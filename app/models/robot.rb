require 'status'

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


    attr_accessor :status

    def code_name=(codename)
      super(code_name =(codename))
      health = codename.get_health
      health.save!
      self.health= health
    end

    def alive?
        remaining_health > 0
    end

    def remaining_health
      if self.health != nil
        return self.health.current
      else
        return nil
      end
    end

    def maximum_health
      if self.health != nil
        return self.health.maximum
      else
        return nil
      end
    end

    def take_damage (damage, effect = nil)
        # should not get lower than 0
        self.health.current -= damage

      if (effect != nil)
        self.status= effect
      end
    end

    def calculate_damage(total_health=1)
      # we emulate skipping turns by making damage equal to 0
      if self.status == "freeze"
        self.status = nil
        return 0
      end
        # doesn't need to be the highest one
        max_damage = self.damage
        robot_weapons.each do |weapon|
            if valid_and_heavier_weapon?(max_damage, weapon)
              max_damage = weapon.damage
              if weapon.effect != nil
                puts(weapon.effect)
                effect = StatusEffect.get(weapon.effect)
                puts(effect)
                max_damage += effect.modify_damage
              end
            end

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

end
