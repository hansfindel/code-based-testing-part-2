class RobotWeapon < ActiveRecord::Base
    belongs_to :robot, inverse_of: :robot_weapons
    belongs_to :weapon 

    has_one :health, as: :machine 

    validates :robot, presence: true
    validates :weapon, presence: true

    validates :health, presence: true
    accepts_nested_attributes_for :health

    after_initialize :check_attrs

    def check_attrs
        unless self.health
            self.health = Health.new 
            self.health.current = 1
            self.health.maximum = 1
        end
    end

    delegate :damage, to: :weapon
    delegate :recoil_damage, to: :weapon

    def stable?
        self.health.current > 0
    end

    def play_dead
        @old_health = health.current if @old_health.blank? or health.current > 0
        health.current = 0
    end

    #Applies recoil effect
    def recoil_effect
        self.robot.take_damage self.recoil_damage
    end

    #Attacks the target
    def attack(target)
        target.take_damage self.damage
    end
end
