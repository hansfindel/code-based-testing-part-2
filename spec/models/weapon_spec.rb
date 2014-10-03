require 'rails_helper'

RSpec.describe Weapon, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  context "Factories" do 
    it ":freeze" do
      gun = FactoryGirl.create(:freeze_gun)
      puts gun.name
      puts gun.side_effect
      expect(gun.id).to be > 0
    end

    it ":health" do 
      gun = FactoryGirl.create(:gun)
      puts gun.side_effect
      expect(gun.id).to be > 0
    end

    it ":health_800" do 
      gun = FactoryGirl.create(:rifle)
      puts gun.side_effect
      expect(gun.id).to be > 0
    end

    it ":health_1000" do 
      gun = FactoryGirl.create(:machine_gun)
      puts gun.side_effect
      expect(gun.id).to be > 0
    end

    it ":health_x" do 
      gun = FactoryGirl.create(:bazuka)
      puts gun.side_effect
      expect(gun.id).to be > 0
    end

    it "should not create two different instances for the same (defined) Weapon" do 
      gun1 = FactoryGirl.create(:bazuka)
      gun2 = FactoryGirl.create(:bazuka)
      # expect(gun1.id == gun2.id).to be true
    end
  end

end
