class RobotWeapon < ActiveRecord::Base
    include HealthManager 

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

    def recoil
        self.weapon.recoil
    end
    
    def can_use?
        self.robot.tech >= self.weapon.tech_need
    end

end
