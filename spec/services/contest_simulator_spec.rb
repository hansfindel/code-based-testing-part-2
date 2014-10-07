require "rails_helper"

RSpec.describe ContestSimulator do

	it "enables multiple teams" do

		team1 = [ 
			FactoryGirl.create(:t_800),
			FactoryGirl.create(:t_1000)
		]

		team2 = [
			FactoryGirl.create(:t_x)
		]


		expect(ContestSimulator.test_multiple(team1, team2)).to eq(team2)
	end
end