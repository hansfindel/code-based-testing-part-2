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
  context "take_weapon_damage" do
    before(:each) do
      @robot = FactoryGirl.create :robot
      @robot_weapon = @robot.robot_weapons.first
    end

    it "should take 1 damage by default" do
      current_health = @robot_weapon.health.current
      @robot_weapon.take_damage
      new_health = @robot_weapon.health.current
      expect(current_health - new_health).to be 1
    end

    it "should take 3 damage by default" do
      current_health = @robot_weapon.health.current
      @robot_weapon.take_damage(3)
      new_health = @robot_weapon.health.current
      expect(current_health - new_health).to be 3
    end
    it "should not get under 0 health" do
      @robot_weapon.take_damage(100)
      expect(@robot_weapon.health.current).to be 0
    end
  end
end
