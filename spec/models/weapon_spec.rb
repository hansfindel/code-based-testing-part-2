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

  context "Tarea1" do

    before(:all) do 
      @gun = FactoryGirl.create(:gun)
    end

    it "should have deterioration" do
      expect(@gun.deterioration.present?).to be true
    end  

    it "should not have deterioration over 100" do
      expect(@gun.deterioration <= 100).to be true
    end  

    it "should not have deterioration under 0" do
      expect(@gun.deterioration >= 0).to be true
    end  

    it "should have attack deterioration" do
      expect(@gun.attack_deterioration.present?).to be true
    end  

    it "should not have attack_deterioration over 100" do
      expect(@gun.attack_deterioration <= 100).to be true
    end  

    it "should not have attack_deterioration under 0" do
      expect(@gun.attack_deterioration >= 0).to be true
    end  

    it "should be usable if deterioration is under 100" do
      expect(@gun.usable?).to be true
    end

    it "should not be usable if deterioration is 100" do
      @gun.deterioration = 100
      expect(@gun.usable?).to be false
    end

    it "should have default damage_nanites of 0" do
      expect(@gun.nanites_damage == 0).to be true
    end 

    it "should be able to be initialized with any nanites_damage value" do
      nanites_gun = FactoryGirl.create(:nanites_gun)
      expect(nanites_gun.nanites_damage == 5).to be true
    end
  end
  
end
