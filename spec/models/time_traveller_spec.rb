require 'rails_helper'

RSpec.describe TimeTraveller, :type => :model do
 
  context "Factories" do 
    pending "add some examples to (or delete) #{__FILE__}"
  end

  context "#valid_and_heavier_weapon?" do 
    before(:all) do 
      @traveller    = TimeTraveller.new # damage: 6
      @gun      = FactoryGirl.create(:gun)
      
      @gun_i    = @gun.time_traveller_weapons.build 
      @gun_i.health.current   = 1
      @gun_i.health.maximum   = 1
      
      # @damage_t = @robot.damage    # 6
      # @damage_g = @gun_i.damage    # 5
    end
    
    it "should return true if gun is undamaged and has heavier damage" do 
      expect(@traveller.valid_and_heavier_weapon?(@gun_i.damage - 1, @gun_i)).to be true
    end

    it "should return false if gun is undamaged but has not a heavier damage" do 
      expect(@traveller.valid_and_heavier_weapon?(@gun_i.damage + 1, @gun_i)).to be false
    end

    it "should return same if gun is damaged - w/heavier damage" do 
      # @gun_i.health.current = 0
      @gun_i.play_dead
      expect(@traveller.valid_and_heavier_weapon?(@gun_i.damage - 1, @gun_i)).to be false
    end

    it "should return same if gun is damaged - w/lower damage" do 
      # @gun_i.health.current = 0
      @gun_i.play_dead
      expect(@traveller.valid_and_heavier_weapon?(@gun_i.damage + 1, @gun_i)).to be false
    end
     
  end
  context "#calculate_damage" do 
    it "should return a number" do 
      # stub valid_and_heavier_weapon?
      traveller = FactoryGirl.create(:time_traveller)
      # robot.unstub
      traveller.stub(:valid_and_heavier_weapon?)
      expect(traveller.calculate_damage).to be > 0 
      # should be a number ... in the future might accept 0
    end

    it "should use valid_and_heavier_weapon? method when it has at least one weapon" do 
      # mock valid_and_heavier_weapon?
      traveller = FactoryGirl.create(:time_traveller)
      traveller.should_receive(:valid_and_heavier_weapon?)
      expect(traveller.calculate_damage).to be > 0 
    end

    it "should use valid_and_heavier_weapon? method when it has at least one weapon" do 
      # mock valid_and_heavier_weapon?
      traveller = FactoryGirl.create(:unarmed_human)
      traveller.should_not_receive(:valid_and_heavier_weapon?)
      expect(traveller.calculate_damage).to be > 0 
    end

    it "should return a number" do 
      traveller = FactoryGirl.create(:time_traveller)
      expect(traveller.calculate_damage).to be > 0 
    end

    context "with recoil" do
      
      it "#should take damage from weapon with recoil" do
        traveller = FactoryGirl.create(:shooter_with_recoil)
        prev_health = traveller.health.current
        traveller.calculate_damage
        expect(traveller.health.current).to be < prev_health 
      end
      
    end

    context "should return a higher number if possible" do 
      it "#should be at least this value" do 
        # currently is the highest one
        traveller = FactoryGirl.create(:time_traveller)
        expect(traveller.calculate_damage).to be >= traveller.damage
      end


      it "#should be equal if weapon is worse than the time traveller's one" do 
        traveller = FactoryGirl.create(:human_with_bad_weapon)
        expect(traveller.calculate_damage).to be traveller.damage
      end

      it "#should be higher if weapon is better than the traveller's one" do 
        traveller = FactoryGirl.create(:human_with_slightly_better_weapon)
        expect(traveller.calculate_damage).to be > traveller.damage     
      end

    end
  end

  context "#alive?" do 
    let(:jhonn_connor) { TimeTraveller.new }
    it "should return true if healthy" do 
      jhonn_connor.should_receive(:remaining_health).and_return(1)
      expect(jhonn_connor.alive?).to be true
    end

    it "should return false if not healthy" do 
      jhonn_connor.should_receive(:remaining_health).and_return(0)
      expect(jhonn_connor.alive?).to be false
    end
  end

end
