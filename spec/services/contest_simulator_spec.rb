require 'rails_helper'

RSpec.describe ContestSimulator do

  context 'frozen ability' do
    it 'booleans status' do
      robot_f = FactoryGirl.create(:robot_with_frozen_weapon)
      robot_n = FactoryGirl.create(:robot)

      # Hack the boolean to freeze robot_n
      robot_f.used_freeze = true
      ContestSimulator.attack(robot_f, robot_n)
      expect(robot_f.used_freeze?).to be false # because was used in #attack and works as a toggle
      expect(robot_n.is_frozen?).to be true
      expect(robot_n.is_frozen?).to be false # because the method works as a toggle
    end

    it 'a frozen robot can not attack' do
      robot_n = FactoryGirl.create(:robot)
      robot_n.is_frozen = true # hack the boolean
      expect(robot_n.calculate_damage(robot_n.damage)).to eq 0
    end

    it 'a frozen robot can attack in his next turn' do
      robot_n = FactoryGirl.create(:robot)
      robot_n.is_frozen = true # hack the boolean
      expect(robot_n.calculate_damage(robot_n.damage)).to eq 0
      expect(robot_n.calculate_damage(robot_n.damage)).to be > 0 # now it can attack :) (next turn simulation)
    end

  end



end
