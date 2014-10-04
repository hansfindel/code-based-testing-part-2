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

require 'rails_helper'

RSpec.describe RobotWeapon, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  context "initialization" do 
    it "should have a health" do 
      robot_weapon = RobotWeapon.new
      expect(robot_weapon).to check_health_at_empty_initialization 
    end
    it "should have a (custom)health" do 
      robot_weapon = RobotWeapon.new
      expect(robot_weapon).to check_attr_at_empty_initialization(:health)
    end
  end

end
