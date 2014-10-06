require 'rails_helper'

RSpec.describe Robot, :type => :model do
 
  context "Factories" do 
    pending "add some examples to (or delete) #{__FILE__}"
  end

  context "#valid_and_heavier_weapon?" do 
    before(:all) do 
      @robot    = FactoryGirl.create(:robot)
      @gun      = FactoryGirl.create(:gun)
      
      @gun_i    = @gun.robot_weapons.build 
      @gun_i.robot            = @robot
      @gun_i.health.current   = 1
      @gun_i.health.maximum   = 1
      
      # @damage_t = @robot.damage    # 6
      # @damage_g = @gun_i.damage    # 5
    end
    
    it "should return true if gun is undamaged and has heavier damage" do 
      @robot.code_name.tech = @gun.tech_need
      expect(@robot.valid_and_heavier_weapon?(@gun_i.damage - 1, @gun_i)).to be true
    end

    it "should return false if gun is undamaged but has not a heavier damage" do 
      @robot.code_name.tech = @gun.tech_need
      expect(@robot.valid_and_heavier_weapon?(@gun_i.damage + 1, @gun_i)).to be false
    end

    it "should return same if gun is damaged - w/heavier damage" do 
      @robot.code_name.tech = @gun.tech_need
      # @gun_i.health.current = 0
      @gun_i.play_dead
      expect(@robot.valid_and_heavier_weapon?(@gun_i.damage - 1, @gun_i)).to be false
    end

    it "should return same if gun is damaged - w/lower damage" do 
      @robot.code_name.tech = @gun.tech_need
      # @gun_i.health.current = 0
      @gun_i.play_dead
      expect(@robot.valid_and_heavier_weapon?(@gun_i.damage + 1, @gun_i)).to be false
    end

    ## NUEVOS - TECH ##
    it "should return false if robot don't have enough tech " do 
      @gun_i.health.current   = 1
      @robot.code_name.tech = @gun.tech_need - 1
      expect(@robot.valid_and_heavier_weapon?(@gun_i.damage - 1 , @gun_i)).to be false
    end
    it "should return true if robot have enough tech " do 
      @robot.code_name.tech = @gun.tech_need
      expect(@robot.valid_and_heavier_weapon?(@gun_i.damage - 1, @gun_i)).to be true
    end
    ## TECH ##

    it "should choose second weapon when the best does not have any health " do 
      robot1      = FactoryGirl.create(:two_weapons_two_bullets_robot)
      gun           = FactoryGirl.create(:gun) 
      rifle         = FactoryGirl.create(:rifle)
      expect(robot1.calculate_damage).to be rifle.damage
      expect(robot1.calculate_damage).to be gun.damage
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

    ### recoil
    context "recoil" do 
      it "#should be affected by recoil" do 
        robot = FactoryGirl.create(:t_x)
        health = robot.remaining_health
        robot.calculate_damage
        expect(robot.remaining_health).to be < health    
      end

    end
  end

  context "#alive?" do 
    let(:wall_e) { FactoryGirl.create(:t_800)  }
    it "should return true if healthy" do 
      wall_e.health.current = 1
      expect(wall_e.alive?).to be true
    end

    it "should return false if not healthy" do 
      wall_e.take_damage wall_e.remaining_health
      expect(wall_e.alive?).to be false
    end
  end

  context "#Fight" do 
    let(:t_800) { FactoryGirl.create(:t_800) }
    it "should atack" do 
      expect(t_800.calculate_damage).to be > 0
    end

    it "should receive damage" do 
      health = t_800.remaining_health
      t_800.take_damage 1
      expect(t_800.remaining_health).to be  health - 1
    end
  end

end
