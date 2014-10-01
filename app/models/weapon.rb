class Weapon < ActiveRecord::Base
    has_many :robot_weapons 
    has_many :robots, through: :robot_weapons

    has_many :time_traveller_weapons 
    has_many :time_travellers, through: :time_traveller_weapons

    validates :recoil, numericality: { greater_than_or_equal_to: 0 }

    validate :check_consistency

    def check_consistency
        # should set recoil to 0 when not given
        unless self.recoil
          self.recoil = 0
        end
    end

    # should be uniq by name - 
    # if created with the same name as one previously saved should return that one 

    # validates :name, uniqueness: true
    # validate :get_instance_by_name 

    def get_instance_by_name
    	# return the existing object if any, otherwise return true
    end

end
