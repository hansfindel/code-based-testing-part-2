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


  context "#stable?" do
    it "should be stable when health > 0" do
      robot = FactoryGirl.create(:robot)
      gun = FactoryGirl.create(:gun)
      robot_weapon = RobotWeapon.new
      robot_weapon.robot = robot
      robot_weapon.weapon = gun
      robot_weapon.save
      expect(robot_weapon.stable?).to be true
    end

    it "shouldn't be stable when health = 0" do
      robot = FactoryGirl.create(:robot)
      gun = FactoryGirl.create(:gun)
      robot_weapon = RobotWeapon.new
      robot_weapon.robot = robot
      robot_weapon.weapon = gun
      robot_weapon.health.current = 0
      robot_weapon.save
      expect(robot_weapon.stable?).to be false
    end
  end

  context "#play_dead" do
    it "should make a weapon be unstable without having taken health damage" do
      robot = FactoryGirl.create(:robot)
      gun = FactoryGirl.create(:gun)
      robot_weapon = RobotWeapon.new
      robot_weapon.robot = robot
      robot_weapon.weapon = gun
      robot_weapon.save
      robot_weapon.play_dead
      expect(robot_weapon.stable?).to be false
    end
  end

end
