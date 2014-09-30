require 'rails_helper'

RSpec.describe Robot, :type => :model do
 
  context "Factories" do 
    pending "add some examples to (or delete) #{__FILE__}"
  end

  context "#regenerate" do 
    before(:all) do 
      @robot1 = FactoryGirl.create(:t_1000)
    end

    it "should return true if regenerated" do 
      @robot1.take_damage 1
      expect(@robot1.regenerate).to be true
    end

    it "should return false if health is full" do 
      expect(@robot1.regenerate).to be false
    end

    it "should return false if health is 0" do 
      @robot1.health.current = 0
      expect(@robot1.regenerate).to be false
    end

    it "should regenerate to maximum health" do 
      @robot2 = FactoryGirl.create(:t_x)
      @robot2.take_damage 1
      @robot2.regenerate 2
      expect(@robot2.remaining_health).to be @robot2.health.maximum
    end
  end

  #dlarrain
  #new weapons
  context "#remaining_weapons?" do
      it "should return false when a weaponless robot calls the method #remaining_weapons?" do
        @robot1 = FactoryGirl.create(:unarmed_robot)
        expect(@robot1.remaining_weapons?).to be false
      end

      it "should return false when all weapons are spent and calls the method #remaining_weapons?" do
        @robot1 = FactoryGirl.create(:t_800)
        @robot1.robot_weapons[0].health.current = 0
        expect(@robot1.remaining_weapons?).to be false
      end

      it "should return true when a robot that have weapons calls the method #remaining_weapons?" do
        @robot1 = FactoryGirl.create(:t_800)
        expect(@robot1.remaining_weapons?).to be true
      end
    end
    
  #dlarrain
  #new weapons
  context "create new weapon when weapons empty" do 
    it "should create a new weapon when #create_new_weapon is called" do
      @robot1 = FactoryGirl.create(:unarmed_robot)
      expect(@robot1.weapons.count).to be(0)
      @robot1.create_new_weapon
      expect(@robot1.weapons.count).to be(1)
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
