# == Schema Information
#
# Table name: weapons
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  damage     :integer
#  created_at :datetime
#  updated_at :datetime
#  min_tech   :integer
#

class Weapon < ActiveRecord::Base
    has_many :robot_weapons 
    has_many :robots, through: :robot_weapons

    # should be uniq by name - 
    # if created with the same name as one previously saved should return that one 

    # validates :name, uniqueness: true
    # validate :get_instance_by_name 

    def get_instance_by_name
    	# return the existing object if any, otherwise return true
    end

end
