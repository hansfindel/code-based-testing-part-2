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

  context "#use" do
    it "should return a number" do
      robot_weapon = RobotWeapon.new
      expect(robot_weapon.use).to be > 0
    end

    it "should be smaller than the initial value" do
      robot_weapon = RobotWeapon.new
      initial_value = robot_weapon.health.current
      expect(robot_weapon.use).to be < initial_value 
    end
  end

end
