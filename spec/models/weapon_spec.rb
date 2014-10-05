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

    it "should not create two different instances for the same (defined) Weapon", focus: true do
      FactoryGirl.create(:bazuka)
      FactoryGirl.create(:bazuka)
      expect(Weapon.where(name: 'Bazuka').count).to be(1)
    end
  end

end
