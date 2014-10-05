require 'rails_helper'

RSpec.describe Weapon, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  context "Factories" do 
    it ":health" do 
      gun = FactoryGirl.create(:gun)
      expect(gun.id).to be > 0
    end

    it ":health_800" do 
      gun = FactoryGirl.create(:rifle)
      expect(gun.id).to be > 0
    end

    it ":health_1000" do 
      gun = FactoryGirl.create(:machine_gun)
      expect(gun.id).to be > 0
    end

    it ":health_x" do 
      gun = FactoryGirl.create(:bazuka)
      expect(gun.id).to be > 0
    end

    it "should not create two different instances for the same (defined) Weapon" do 
      gun1 = FactoryGirl.create(:bazuka)
      gun2 = FactoryGirl.create(:bazuka)
      # expect(gun1.id == gun2.id).to be true
    end
  end


  context "Recoil effect" do
    it "should not create a weapon without recoil param" do
      weapon = Weapon.create
      expect(weapon.id).to be nil
    end

    it "should not create a weapon with recoil_damage < 0" do
      weapon = Weapon.create(recoil_damage:-1)
      expect(weapon.id).to be nil
    end

    it "should create a weapon with valid recoil_damage" do
      weapon = Weapon.create(recoil_damage:10)
      expect(weapon.id).to be > 0
    end

    it "should apply recoil_damage when used" do
      robot = FactoryGirl.create(:unarmed_robot) #current health = 50
      weapon = Weapon.create(damage:10, recoil_damage:10)
      robot.weapons << weapon
      robot.robot_weapons[0].use
      expect(robot.health.current == 40).to be true
    end

  end

end
