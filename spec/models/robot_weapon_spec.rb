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

#neew

  context "#health" do 
    before(:all) do 
      @gun      = FactoryGirl.create(:gun)
      @gun_i    = @gun.robot_weapons.build 
      @gun_i.health.current   = 1
      @gun_i.health.maximum   = 1
    end

    it "should return true if healthy" do 
      @gun_i.health.current   = 1
      expect(@gun_i.stable?).to be true
    end

    it "should receive damage when shots" do
      @gun_i.health.current   = 1
      expect(@gun_i.spent_bullet).to be 0
    end

    it "should return false if not healthy" do 
      @gun_i.take_damage @gun_i.remaining_health
      expect(@gun_i.stable?).to be false
    end
  end

end
