require 'rails_helper'

RSpec.describe ContestSimulator do
	before(:all) do 
        @r_fast = Robot.find(1) || FactoryGirl.create(:robot) #delay = 5
        @r_slow = Robot.find(2) || FactoryGirl.create(:t_x) #delay = 15
    end

	context "fight time" do

		it "shouldn't fight at time = 0" do
			r_fast_initial = @r_fast.remaining_health
			r_slow_initial = @r_slow.remaining_health
			ContestSimulator.fight(@r_fast, @r_slow, 0)
			expect(@r_fast.remaining_health).to eq(r_fast_initial)
			expect(@r_slow.remaining_health).to eq(r_slow_initial)
		end

		it "should fight at lowest delay time" do
			r_fast_initial = @r_fast.remaining_health
			r_slow_initial = @r_slow.remaining_health
			time = [@r_slow.delay, @r_fast.delay].min
			ContestSimulator.fight(@r_fast, @r_slow, time)
			expect(@r_slow.remaining_health).to be < r_slow_initial if @r_fast.delay.eql? time
			expect(@r_fast.remaining_health).to be < r_fast_initial if @r_slow.delay.eql? time
		end



	end
end