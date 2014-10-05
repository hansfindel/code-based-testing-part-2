require 'rails_helper'

RSpec.describe Robot, :type => :model do
 
  context "Factories" do 
    pending "add some examples to (or delete) #{__FILE__}"
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
      #robot.stub(:valid_and_heavier_weapon?)
      expect(robot.calculate_damage).to be > 0 
      # should be a number ... in the future might accept 0
    end

    it "should return a number" do
      robot = FactoryGirl.create(:robot)
      expect(robot.calculate_damage).to be > 0 
    end

    context "should be optimized" do

      it "Should return robot damage if the total_health is equal to the robot damage" do
        robot = FactoryGirl.create(:t_x)

        expect(robot.calculate_damage(robot.damage)).to eq(robot.damage)
      end

      it "Should return a weapon damage if the total_health is equal to a weapon damage" do
        robot = FactoryGirl.create(:t_x)
        damages = robot.weapons.pluck(:damage)

        damages.each do |damage|
          expect(robot.calculate_damage(damage)).to eq(damage)
        end

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

  context '#frozen ability' do

    it "Should be created with is_frozen false" do
      robot = Robot.new
      expect(robot.is_frozen).to eq false
    end

    it "Should freeze if the weapon used has freeze ability" do
      robot = FactoryGirl.create(:robot_with_frozen_weapon)
      expect(robot.used_freeze?).to eq false
      expect(robot.calculate_damage(3)).to eq(3)
      expect(robot.used_freeze?).to eq true
      expect(robot.used_freeze?).to eq false
    end

  end

end
