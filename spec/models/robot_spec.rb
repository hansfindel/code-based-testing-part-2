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

  context "#tarea" do
    it "should regenerate after attack" do
      robot1 = FactoryGirl.create(:robot)
      robot2 = FactoryGirl.create(:robot)
      puts robot2.health.current #empieza con 50
      ContestSimulator.attack(robot1, robot2)
      current_health_1 = robot2.health.current
      puts current_health_1 #luego de recibir ataque queda con 45
      ContestSimulator.attack(robot2, robot1)
      current_health_2 = robot2.health.current
      puts current_health_2 #luego de atacar aumenta a 46
      expect(current_health_1 < current_health_2).to be true
    end

    it "T_1000 can't use bazuka" do
      robot = FactoryGirl.create(:t_1000)
      bazuka = FactoryGirl.create(:bazuka)
      ret = attach_to_robot_weapon_with_health_value(robot, bazuka, 70)
      expect(ret.to_s == "T_1000 can't use bazuka").to be true
    end

    it "T_800 can't use bazuka" do
      robot = FactoryGirl.create(:t_800)
      bazuka = FactoryGirl.create(:bazuka)
      ret = attach_to_robot_weapon_with_health_value(robot, bazuka, 70)
      expect(ret.to_s == "T_800 can't use bazuka").to be true
    end

    it "T_800 can't use machine gun" do
      robot = FactoryGirl.create(:t_800)
      machine_gun = FactoryGirl.create(:machine_gun)
      ret = attach_to_robot_weapon_with_health_value(robot, machine_gun, 20)
      expect(ret.to_s == "T_800 can't use machine gun").to be true
    end
  end

end
