require 'rails_helper'

RSpec.describe Health, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  
  context "Factories" do 
    it ":health" do 
      health = FactoryGirl.create(:health)
      expect(health.id).to be > 0
    end

    it ":health_800" do 
      health = FactoryGirl.create(:health_800)
      expect(health.id).to be > 0
    end

    it ":health_1000" do 
      health = FactoryGirl.create(:health_1000)
      expect(health.id).to be > 0
    end

    it ":health_x" do 
      health = FactoryGirl.create(:health_x)
      expect(health.id).to be > 0
    end

    it ":health_x - same test written differently" do 
      health = FactoryGirl.create(:health_x)
      health.save  # health.valid? 
      expect(health.errors).to be_empty
    end
  end

  context "#methods" do 
    it "should have current < maximum" do 
      health = FactoryGirl.create(:health_800)
      health.current = health.maximum - 1
      # expect(health.current).to be < health.maximum
      health.valid?
      expect(health.errors.has_key?(:current)).to be false
    end

    it "should be valid current == maximum" do 
      health = FactoryGirl.create(:health_800)
      health.current = health.maximum 
      health.valid?
      expect(health.errors.has_key?(:current)).to be false
    end

    it "should fail if current > maximum" do 
      health = FactoryGirl.create(:health_800)
      health.current = health.maximum + 1
      health.save
      puts health.errors.messages.to_s
      expect(health.errors.has_key?(:current)).to be true
    end
  end

end
