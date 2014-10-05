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

  end

  context "Tarea 1" do
    it "should not create two different instances for the same defined weapon" do 
      gun1 = FactoryGirl.create(:bazuka)
      gun2 = FactoryGirl.create(:bazuka)
      expect(gun1.id == gun2.id).to be true
    end

    it "should create two different instances for the different weapons" do 
      gun1 = FactoryGirl.create(:bazuka)
      gun2 = FactoryGirl.create(:machine_gun)
      expect(gun1.id != gun2.id).to be true
    end

    it "should not receive damage and do damage" do 
      robot1 = FactoryGirl.create(:no_recoil_robot)
      robot2 = FactoryGirl.create(:full_recoil_robot)
      robot1.attack(robot2)
      expect(robot1.health.current).to be == 100
      expect(robot2.health.current).to be == 0
    end

    it "should not receive damage and do default damage" do 
      robot1 = FactoryGirl.create(:full_recoil_robot)
      robot2 = FactoryGirl.create(:no_recoil_robot)
      robot1.attack(robot2)
      expect(robot1.health.current).to be == 100
      expect(robot2.health.current).to be == 95
    end

    it "should receive damage and do damage" do 
      robot1 = FactoryGirl.create(:mid_recoil_robot)
      robot2 = FactoryGirl.create(:full_recoil_robot)
      robot1.attack(robot2)
      expect(robot1.health.current).to be == 50
      expect(robot2.health.current).to be == 50
    end

    it "should freeze enemy and therefor not receive damage" do 
      robot1 = FactoryGirl.create(:mrFreeze_robot)
      robot2 = FactoryGirl.create(:no_mrFreeze_robot)
      robot1.attack(robot2)
      expect(robot1.health.current).to be == 100
      expect(robot2.health.current).to be == 50
      robot2.attack(robot1)
      expect(robot1.health.current).to be == 100
      expect(robot2.health.current).to be == 50
    end

    it "should not freeze enemy and therefor receive damage" do 
      robot1 = FactoryGirl.create(:no_mrFreeze_robot)
      robot2 = FactoryGirl.create(:no_mrFreeze_robot)
      robot1.attack(robot2)
      expect(robot1.health.current).to be == 100
      expect(robot2.health.current).to be == 30
      robot2.attack(robot1)
      expect(robot1.health.current).to be == 30
      expect(robot2.health.current).to be == 30
    end

  end

end
