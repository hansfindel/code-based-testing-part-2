require 'rails_helper'

  describe "contest simulator" do
    context "get_result" do
      before(:each) do
        @r1 = FactoryGirl.create :robot #damage = 5, health = 50
        @r2 = FactoryGirl.create :robot #damage = 5, health = 50
      end
      it "should rais error if both robots are alive" do
        expect { ContestSimulator.get_result(@r1,@r2) }.to raise_error
      end
    end
    context "1vs1 simultaneous attack (test)" do
      before(:each) do
        @r1 = FactoryGirl.create :robot #damage = 5, health = 50
        @r3 = FactoryGirl.create :robot #damage = 5, health = 50
        @r2 = FactoryGirl.create :t_800 #damage = 10, health = 80
      end
      it "should be a 'Tragic Tie' when same damage and health" do
        # empty array means tie
        expect(ContestSimulator.test(@r1,@r3)).to match_array([])
      end
      it "should win contender1 r2" do
        result = ContestSimulator.test(@r2,@r1)
        expect(result).to be_kind_of(Array)
        expect(result.length).to be 1
        expect(result).to include @r2
      end
      it "should win contender2 r2" do
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
    context "asynchronous_test" do
      before(:each) do
        @r1 = FactoryGirl.create :robot # damage 5 , health 50
        @r1.update_attributes(max_attack_velocity: 5, attack_velocity: 5)
        @r2 = FactoryGirl.create :robot # damage 5 , health 50
        @r2.update_attributes(max_attack_velocity: 3, attack_velocity: 3)
        @r3 = FactoryGirl.create :robot # damage 5 , health 50
        @r3.update_attributes(max_attack_velocity: 3, attack_velocity: 3)
      end
      # Test se demora 30 segundos en dar por ganador a contender2
      it "should win robot with less attack_velocity if other properties are constant" do
        ContestSimulator.asynchronous_test(@r1,@r2)
        expect(ContestSimulator.get_result(@r1,@r2)).to include @r2
      end
      # Test se demora 30 segundos en determinar el empate
      it "should be a Tie if both robots have same properties" do
        ContestSimulator.asynchronous_test(@r2,@r3)
        expect(ContestSimulator.get_result(@r2,@r3)).to match_array([])
      end
    end
  end