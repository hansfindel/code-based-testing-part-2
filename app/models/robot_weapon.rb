# == Schema Information
#
# Table name: robot_weapons
#
#  id         :integer          not null, primary key
#  robot_id   :integer
#  weapon_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class RobotWeapon < ActiveRecord::Base
    belongs_to :robot 
    belongs_to :weapon 

    has_one :health, as: :machine 

    validates :robot, presence: true
    validates :weapon, presence: true

    validates :health, presence: true
    accepts_nested_attributes_for :health

    delegate :min_tech, to: :weapon

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

    def play_dead
        @old_health = health.current if @old_health.blank? or health.current > 0
        health.current = 0
    end
end
