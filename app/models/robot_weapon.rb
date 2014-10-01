class RobotWeapon < ActiveRecord::Base
    include RobotWeaponHealth

    belongs_to :robot 
    belongs_to :weapon 

    has_one :health, as: :machine 

    validates :robot, presence: true
    validates :weapon, presence: true

    validates :health, presence: true
    accepts_nested_attributes_for :health

    after_initialize :check_attrs

    delegate :damage, to: :weapon

end
