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

    it "should not allow high tech_level weapons for low tech_level robots" do 
      robot_weapon = RobotWeapon.new
      robot_weapon.robot = FactoryGirl.create(:robot)
      robot_weapon.weapon = FactoryGirl.create(:high_tech)
      robot_weapon.valid?
      expect(robot_weapon.errors.has_key?(:weapon)).to be true
    end

    it "should allow high tech_level weapons for high tech_level robots" do 
      robot_weapon = RobotWeapon.new
      robot_weapon.robot = FactoryGirl.create(:advanced_robot)
      robot_weapon.weapon = FactoryGirl.create(:high_tech)
      robot_weapon.valid?
      #expect(robot_weapon.errors.has_key?(:weapon)).to be false
      expect(robot_weapon.robot.tech_level).to eq 10
    end
  end

end
