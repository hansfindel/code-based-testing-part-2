class RobotWeapon < ActiveRecord::Base
    belongs_to :robot 
    belongs_to :weapon 

    has_one :health, as: :healthy 

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
    delegate :recoil, to: :weapon

    validate :check_tech_level

    def check_tech_level
        if robot and weapon
            if robot.tech_level < weapon.tech_level
                errors.add(:weapon, "Weapon's tech level is to high for this robot to use.")
            end
        end
    end

    def stable?
        self.health.current > 0
    end

    def play_dead
        @old_health = health.current if @old_health.blank? or health.current > 0
        health.current = 0
    end
end
