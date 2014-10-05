module TestTemps
  class HasFighterAbilitiesDouble < ActiveRecord::Base

    include HasFighterAbilities
  end
end

describe HasFighterAbilities do
  context 'when included in a class' do
    subject(:with_fighter_abilities) {TestTemps::HasFighterAbilities.new}

    it_behaves_like 'has_fighter_abilities'
  end
end