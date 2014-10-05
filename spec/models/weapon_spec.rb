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

  end

end
