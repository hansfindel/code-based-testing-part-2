require 'rails_helper'

RSpec.describe Robot, :type => :model do
 
  context "Factories" do 
    pending "add some examples to (or delete) #{__FILE__}"
  end

  context "Weapons with special effects" do
    it "burn effect" do
      robot = FactoryGirl.create(:robot_with_flamethrower)
      damage = robot.calculate_damage
      expect(damage).to eq(32)
    end

    it "freeze effect" do
      robot = FactoryGirl.create(:t_1000)
      damage = robot.calculate_damage
      expect(damage > 0).to be(true)

      robot.status = "freeze"
      damage = robot.calculate_damage
      expect(damage == 0).to be(true)

      # After one calculate damage, effect should be over
      damage = robot.calculate_damage
      expect(damage > 0).to be(true)


    end
  end

  context "Test default health from code_name" do


    it "robots have default health from code name" do
      robot = FactoryGirl.create(:t_1000)
      expect(robot.remaining_health).to eq(100)
      expect(robot.maximum_health).to eq(100)
    end

    it "instantiated robot with code_name has default health" do
      robot = Robot.new
      expect(robot.remaining_health).to be_nil

      robot = Robot.new({code_name: FactoryGirl.create(:T_1000)})
      expect(robot.remaining_health).to eq(100)
      expect(robot.maximum_health).to eq(100)
    end

    it "assigning code_name assigns health" do
      robot = Robot.new
      expect(robot.remaining_health).to be_nil

      robot.public_send("code_name=", FactoryGirl.create(:T_1000))
      expect(robot.remaining_health).to eq(100)
      expect(robot.maximum_health).to eq(100)
    end

    it "cannot save robot without health nor codename" do
      robot = Robot.new
      check = robot.save
      expect(check).to be(false)
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

end
