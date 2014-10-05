require 'rails_helper'

RSpec.describe Robot, :type => :model do
 
  context "Factories" do 
    pending "add some examples to (or delete) #{__FILE__}"
  end

  context "#valid_and_heavier_and_technology_weapon?" do 
    before(:all) do 
      @robot    = FactoryGirl.create(:robot) # damage: 6, technology: 6
      @gun      = FactoryGirl.create(:gun)
      @rifle    = FactoryGirl.create(:rifle)
      
      @gun_i    = @gun.robot_weapons.build # damage: 5, technology: 5
      @gun_i.health.current   = 1
      @gun_i.health.maximum   = 1 

      @rifle_i    = @rifle.robot_weapons.build # damage:10, technology: 10
      @rifle_i.health.current   = 1
      @rifle_i.health.maximum   = 1 
      
    end
    
    it "should return true if gun is undamaged and has heavier damage and has required technology level" do 
      expect(@robot.valid_and_heavier_and_technology_weapon?(@gun_i.damage - 1, @gun_i)).to be true
    end

     it "should return false if gun is undamaged and has heavier damage and has not required technology level" do 
      expect(@robot.valid_and_heavier_and_technology_weapon?(@rifle_i.damage - 6, @rifle_i)).to be false
    end

    it "should return false if gun is undamaged but has not a heavier damage and has required technology level" do 
      expect(@robot.valid_and_heavier_and_technology_weapon?(@gun_i.damage + 1, @gun_i)).to be false
    end

    it "should return false if gun is undamaged but has not a heavier damage and has not required technology level" do 
      expect(@robot.valid_and_heavier_and_technology_weapon?(@rifle_i.damage , @rifle_i)).to be false
    end

    it "should return same if gun is damaged - w/heavier damage and has required technology level" do 
      # @gun_i.health.current = 0
      @gun_i.play_dead
      expect(@robot.valid_and_heavier_and_technology_weapon?(@gun_i.damage - 1, @gun_i)).to be false
    end

    it "should return same if gun is damaged - w/heavier damage and has not required technology level" do 
      # @gun_i.health.current = 0
      @rifle_i.play_dead
      expect(@robot.valid_and_heavier_and_technology_weapon?(@rifle_i.damage - 6, @rifle_i)).to be false
    end

    it "should return same if gun is damaged - w/lower damage and has required technology level" do 
      # @gun_i.health.current = 0
      @gun_i.play_dead
      expect(@robot.valid_and_heavier_and_technology_weapon?(@gun_i.damage + 1, @gun_i)).to be false
    end

    it "should return same if gun is damaged - w/lower damage and has required technology level" do 
      # @gun_i.health.current = 0
      @rifle_i.play_dead
      expect(@robot.valid_and_heavier_and_technology_weapon?(@rifle_i.damage, @rifle_i)).to be false
    end
     
  end
  context "#calculate_damage" do 
    it "should return a number" do 
      # stub valid_and_heavier_and_technology_weapon?
      robot = FactoryGirl.create(:robot)
      # robot.unstub
      robot.stub(:valid_and_heavier_weapon?)
      expect(robot.calculate_damage).to be > 0 
      # should be a number ... in the future might accept 0
    end

    it "should use valid_and_heavier_and_technology_weapon? method when it has at least one weapon" do 
      # mock valid_and_heavier_and_technology_weapon?
      robot = FactoryGirl.create(:robot)
      robot.should_receive(:valid_and_heavier_weapon?)
      expect(robot.calculate_damage).to be > 0 
    end

    it "should use valid_and_heavier_and_technology_weapon? method when it has at least one weapon" do 
      # mock valid_and_heavier_and_technology_weapon?
      robot = FactoryGirl.create(:unarmed_robot)
      robot.should_not_receive(:valid_and_heavier_weapon?)
      expect(robot.calculate_damage).to be > 0 
    end

    it "should return a number" do 
      robot = FactoryGirl.create(:robot)
      expect(robot.calculate_damage).to be > 0 
    end

    context "should return a higher number if possible" do 
      it "#should be at least this value" do 
        # currently is the highest one
        robot = FactoryGirl.create(:robot)
        expect(robot.calculate_damage).to be >= robot.damage
      end

      it "#should be equal if weapon is worse than the machines one" do 
        robot = FactoryGirl.create(:robot_with_bad_weapon)
        expect(robot.calculate_damage).to be robot.damage
      end

      it "#should be higher if weapon is better than the machines one" do 
        robot = FactoryGirl.create(:robot_with_slightly_better_weapon)
        expect(robot.calculate_damage).to be > robot.damage     
      end

    end
  end

  context "#alive?" do 
    let(:wall_e) { Robot.new }
    it "should return true if healthy" do 
      wall_e.should_receive(:remaining_health).and_return(1)
      expect(wall_e.alive?).to be true
    end

    it "should return false if not healthy" do 
      wall_e.should_receive(:remaining_health).and_return(0)
      expect(wall_e.alive?).to be false
    end
  end

end
