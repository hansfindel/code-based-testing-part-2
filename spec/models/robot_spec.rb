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

  context "#remaining_health" do
    it "should return current health" do
      robot = FactoryGirl.create(:robot)
      expect(robot.remaining_health).to be robot.health.current
    end
  end

  context "#take_damage" do
    it "should decrease remaining health by that amount" do
      robot = FactoryGirl.create(:robot)
      original_health = robot.remaining_health
      damage_to_inflict = 5
      robot.take_damage damage_to_inflict
      expect(robot.remaining_health).to be original_health - damage_to_inflict
    end
  end

  context "#attack_weapon_freezes?" do
    it "should be true when weapon used to attack can freeze" do
      robot = FactoryGirl.create(:freeze_robot)
      expect(robot.attack_weapon_freezes?).to be true
    end

    it "should be true when weapon used to attack can't freeze" do
      robot = FactoryGirl.create(:robot)
      expect(robot.attack_weapon_freezes?).to be false
    end
  end

end
