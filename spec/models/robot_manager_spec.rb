require 'rails_helper'

RSpec.describe Robot, :type => :model do
 

  context "#alive?" do 
    let(:wall_e) { Robot.new }
    it "should return true if healthy" do 
      puts "hola"
      puts wall_e.salute
      puts wall_e.salute2
      expect(wall_e.alive?).to be true
    end


  end

end
