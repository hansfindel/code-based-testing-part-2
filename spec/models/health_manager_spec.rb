require 'rails_helper'

RSpec.describe Robot, :type => :model do
 

  context "#alive?" do 
    let(:wall_e) { FactoryGirl.create(:t_800) }
    it "should return true if healthy" do 
      # wall_e.salute2
      expect(wall_e.alive?).to be true
    end


  end

end
