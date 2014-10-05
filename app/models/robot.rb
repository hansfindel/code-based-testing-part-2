class Robot < ActiveRecord::Base
    include AutoPresentable
    include HasFighterAbilities

    has_many :robot_weapons
    has_many :weapons, through: :robot_weapons

    accepts_nested_attributes_for :robot_weapons

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
