require 'rails_helper'

RSpec.describe Fighter, :type => :model do


  context "#alive?" do 
    let(:bruce) { FactoryGirl.create(:fighter_bruce_lee) }
    it "should return true if healthy" do 
      expect(bruce.alive?).to be true
    end

    it "should return false if not healthy" do 
      bruce.take_damage bruce.remaining_health
      expect(wall_e.alive?).to be false
    end
  end

  context "#Fight" do 
    let(:bruce) { FactoryGirl.create(:fighter_bruce_lee) }
    it "should atack" do 
      expect(bruce.alive?).to be true
    end

    it "should receive damage" do 
      health = bruce.remaining_health
      bruce.take_damage 1
      expect(wall_e.remaining_health).to be = health - 1
    end
  end

end
