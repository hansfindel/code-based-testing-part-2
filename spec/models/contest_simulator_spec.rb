require 'rails_helper'

RSpec.describe ContestSimulator, :type => :model do
  before(:each) do
    @robot1= FactoryGirl.create(:robot)
    @robot2= FactoryGirl.create(:robot)
    @dead_robot1= FactoryGirl.create(:robot)
    @dead_robot1.health.current=0
    @dead_robot2= FactoryGirl.create(:robot)
    @dead_robot2.health.current=0
  end

  context "Results from a Contest between TWO ROBOTS" do

    it "should raise an error if both robots are alive" do
      expect{ContestSimulator.get_result(@robot1,@robot2)}.to raise_error{ImpossibleError}
    end

    it "should return an array" do
      expect(ContestSimulator.get_result(@robot1,@dead_robot1)).to be_a Array
    end

    it "should return an empty array if both robots died" do
      expect(ContestSimulator.get_result(@dead_robot1,@dead_robot2).count).to be 0
    end

    it "should return an array with 1 element" do
      expect(ContestSimulator.get_result(@dead_robot1,@robot2).count).to be 1
    end

    it "should return the first contender because he is alive" do
      expect(ContestSimulator.get_result(@robot1,@dead_robot1)).to include @robot1
    end

    it "should return the second contender because he is alive" do
      expect(ContestSimulator.get_result(@dead_robot1,@robot1)).to include @robot1
    end

  end

  context "during a contest" do
    describe "in fight of one round" do
      it "should call calculate_damage exactly one time per each contender" do
        @robot3= FactoryGirl.create(:robot)
        @robot4= FactoryGirl.create(:robot)
        base_health=40
        @robot3.should_receive(:calculate_damage).exactly(1).times.and_return(base_health)
        @robot4.should_receive(:calculate_damage).exactly(1).times.and_return(base_health)
        @robot3.health.current=base_health
        @robot4.health.current=base_health
        #I didn't found another way to check this behaviour because mocking another method like attack ends up in an infinite loop
        #ContestSimulator.should_receive(:attack).exactly(2).times
        ContestSimulator.test(@robot3,@robot4)
      end

      it "should call regenerate_after_attack exactly one time per each contender" do
        @robot1.health.current=1
        @robot2.health.current=1
        @robot1.should_receive(:regenerate_after_attack).exactly(1).times
        @robot2.should_receive(:regenerate_after_attack).exactly(1).times
        ContestSimulator.test(@robot1,@robot2)
      end
    end

    it "should reduce robot health after an attack" do
      current= @robot2.health.current
      ContestSimulator.send(:attack,@robot1,@robot2)
      expect(@robot2.health.current). to be < current
    end
  end
  context "Tournaments" do
    before(:each) do
      @robot3= FactoryGirl.create(:robot)
      @robot4= FactoryGirl.create(:robot)
      @robot1.health.current=1
      @robot2.health.current=1
    end
    it "should return the team 2 winner" do
      expect(ContestSimulator.test([@robot1,@robot2],[@robot3,@robot4])). to include(@robot3,@robot4)
    end

    it "should return the team 1 winner" do
      @team1=[@robot3,@robot4]
      @team2=[@robot1,@robot2]
      expect(ContestSimulator.test(@team1,@team2)). to include(@robot3,@robot4)
    end

    it "should remove destroyed robots from teams" do
      @team1=[@robot1,@robot2]
      @team2=[@robot3,@robot4]
      ContestSimulator.test(@team1,@team2)
      expect(@team1.count). to be 0
    end

    it "should allow tragic ties in teams" do
      @team1=[@robot1]
      @team2=[@robot2]
      expect(ContestSimulator.test(@team1,@team2)).to be nil
      expect(@team1.count).to be 0
      expect(@team2.count).to be 0
    end

  end


end
