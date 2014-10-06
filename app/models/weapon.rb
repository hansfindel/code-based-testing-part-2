class Weapon < ActiveRecord::Base
    has_many :robot_weapons 
    has_many :robots, through: :robot_weapons

    # should be uniq by name - 
    # if created with the same name as one previously saved should return that one 

    # validates :name, uniqueness: true
    # validate :get_instance_by_name 

    def get_instance_by_name
    	Weapon.find_by_name(self.name)
    end
	def save!
		weapon=get_instance_by_name
		if weapon.present?
			self.id=weapon.id
		else
			super
		end
	end
end
