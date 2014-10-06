require 'rails_helper'

  describe "contest simulator" do

    context "1vs1 simultaneous attack (test)" do
      before(:each) do
        @r1 = FactoryGirl.create :robot #damage = 5, health = 50
        @r3 = FactoryGirl.create :robot #damage = 5, health = 50
        @r2 = FactoryGirl.create :t_800 #damage = 10, health = 80
      end
      it "should be a 'Tragic Tie'" do
        # empty array means tie
        expect(ContestSimulator.test(@r1,@r3)).to match_array([])
      end
      it "should win contender1" do
        result = ContestSimulator.test(@r2,@r1)
        expect(result).to be_kind_of(Array)
        expect(result.length).to be 1
        expect(result).to include @r2
      end
      it "should win contender2" do
        # se cambió de posición para verificar que funciona de ambas maneras
        result = ContestSimulator.test(@r1,@r2)
        expect(result).to be_kind_of(Array)
        expect(result.length).to be 1
        expect(result).to include @r2
      end
    end
    context "team vs team simultaneous attack (team_challenge)" do
      before(:each) do
        @team1 = [FactoryGirl.create(:robot), FactoryGirl.create(:robot)]
        @team2 = [FactoryGirl.create(:robot), FactoryGirl.create(:robot)]
        @team3 = [FactoryGirl.create(:robot), FactoryGirl.create(:t_800)]
        @team4 = []
        @team5 = []
      end

      it "should lose team with NO robots" do
        expect(ContestSimulator.team_challenge(@team1, @team4)).equal? "Team1"
      end
      it "should be a Tie if both teams have NO robots" do
        expect(ContestSimulator.team_challenge(@team4, @team5)).equal? "Tie"
      end
      it "should be TIE if both teams have same strength" do
        expect(ContestSimulator.team_challenge(@team1, @team2)).equal? "Tie"
      end
      it "should win the stronger team" do
        expect(ContestSimulator.team_challenge(@team1, @team3)).equal? "Team2"
      end
    end
  end