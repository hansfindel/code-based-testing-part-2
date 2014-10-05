class RobotWeapon < ActiveRecord::Base
    belongs_to :robot 
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

    def stable?
        self.health.current > 0
    end

    def can_use?
        self.robot.tech >= self.weapon.tech_need
    end

    def recoil
        self.weapon.recoil
    end

    def spent_bullet
        self.health.take_damage 1
        self.health.current
    end

    def take_damage damage 
        # should not get lower than 0
        self.health.take_damage damage
    end

    def play_dead
        @old_health = health.current if @old_health.blank? or health.current > 0
        health.current = 0
    end
end
