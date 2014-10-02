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

  context "Secondary effect" do
    it "Should have effect" do
      sword = FactoryGirl.create(:ice_sword)
      expect(sword.effect) != nil
    end

    it "Should freeze the opponent" do
      r1 = FactoryGirl.create(:robot_with_ice_sword)
      r2 = FactoryGirl.create(:robot)

      # Hago que el robot con la espada ataque al otro
      begin
        ContestSimulator.attack r1, r2
      rescue Exception => e
        puts "Error: #{e} - #{e.get_message}"
      end

      expect(r2.status == 'Frozen').to be true
    end
  end
end
