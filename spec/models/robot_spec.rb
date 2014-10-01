require 'rails_helper'

RSpec.describe Robot, :type => :model do
 
  context "Factories" do
    context "Default robot" do
      before(:all) do
        @robot = FactoryGirl.create(:robot)
      end
      it "has health>0" do
        expect(@robot.health.current).to be >0
      end
      it "has a valid weapon with damage>0" do
        expect(@robot.calculate_damage).to be >0
      end
      it "doesn't have a regenerating attack" do
        expect(@robot.regenerating_attack).to be false
      end
      it "doesn't have any nanite" do
        expect(@robot.nanites).to be 0
      end
    end
    context "Robots with regenerating attack" do
      it "t_1000 should have regenerating attack" do
        @robot = FactoryGirl.create(:t_1000)
        expect(@robot.regenerating_attack).to be true
      end
      it "t_x should have regenerating attack" do
        @robot = FactoryGirl.create(:t_x)
        expect(@robot.regenerating_attack).to be true
      end
    end

  end

  context "#valid_and_heavier_weapon?" do 
    before(:all) do 
      @robot    = Robot.new # damage: 6
      @gun      = FactoryGirl.create(:gun)
      
      @gun_i    = @gun.robot_weapons.build 
      @gun_i.health.current   = 1
      @gun_i.health.maximum   = 1
      
      # @damage_t = @robot.damage    # 6
      # @damage_g = @gun_i.damage    # 5
    end
    
    it "should return true if gun is undamaged and has heavier damage" do 
      expect(@robot.valid_and_heavier_weapon?(@gun_i.damage - 1, @gun_i)).to be true
    end

    it "should return false if gun is undamaged but has not a heavier damage" do 
      expect(@robot.valid_and_heavier_weapon?(@gun_i.damage + 1, @gun_i)).to be false
    end

    it "should return same if gun is damaged - w/heavier damage" do 
      # @gun_i.health.current = 0
      @gun_i.play_dead
      expect(@robot.valid_and_heavier_weapon?(@gun_i.damage - 1, @gun_i)).to be false
    end

    it "should return same if gun is damaged - w/lower damage" do 
      # @gun_i.health.current = 0
      @gun_i.play_dead
      expect(@robot.valid_and_heavier_weapon?(@gun_i.damage + 1, @gun_i)).to be false
    end
     
  end
  context "#calculate_damage" do 
    it "should return a number" do 
      # stub valid_and_heavier_weapon?
      robot = FactoryGirl.create(:robot)
      # robot.unstub
      robot.stub(:valid_and_heavier_weapon?)
      expect(robot.calculate_damage).to be > 0 
      # should be a number ... in the future might accept 0
    end

    it "should use valid_and_heavier_weapon? method when it has at least one weapon" do 
      # mock valid_and_heavier_weapon?
      robot = FactoryGirl.create(:robot)
      robot.should_receive(:valid_and_heavier_weapon?)
      expect(robot.calculate_damage).to be > 0 
    end

    it "should use valid_and_heavier_weapon? method when it has at least one weapon" do 
      # mock valid_and_heavier_weapon?
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

  context "Contest Effects" do
    describe "Regenerating attack" do
      #current should be always <=Maximum but that behaviour is leave to Health class to do a validation that in that case
      #current is set to maximum
      it "should regenerate a constant value" do
        robot = FactoryGirl.create(:t_1000)
        current = robot.health.current = 1
        change = robot.health.maximum*Robot::REGENERATING_ATTACK_PERCENTAGE
        expect { robot.regenerate_after_attack }.to change { robot.health.current }.from(current).to(current+change)
      end
      it "should not regenarate health for robots without regenerating attack" do
        robot = FactoryGirl.create(:robot)
        expect { robot.regenerate_after_attack }.to change { robot.health.current }.by(0)
      end
    end

    describe "Nanite damage" do
      #current should be always >=0 but that behaviour is leave to Health class to do a validation that in that case
      #current is set to 0
      it "should lose health proportional to nanites" do
        robot = FactoryGirl.create(:t_1000)
        robot.nanites = 2
        robot.health.current = robot.health.maximum
        current = robot.health.current
        change = robot.nanites*Robot::NANITE_DAMAGE_AMOUNT
        expect { robot.take_nanite_damage }.to change { robot.health.current }.from(current).to(current-change)
      end

      it "should not lose health without nanites" do
        robot = FactoryGirl.create(:t_1000)
        expect { robot.take_nanite_damage }.to change { robot.health.current }.by(0)
      end
    end

  end
end
