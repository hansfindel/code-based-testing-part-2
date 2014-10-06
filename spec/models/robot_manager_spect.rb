require 'rails_helper'

RSpec.describe Robot, :type => :model do
 

  context "#alive?" do 
    let(:wall_e) { FactoryGirl.create(:t_800) }
    it "should return true if healthy" do 
      puts "hola"
      puts wall_e.to_s
      puts FactoryGirl.create(:t_800).salute2.to_s
      expect(wall_e.alive?).to be true
    end


  end

end
