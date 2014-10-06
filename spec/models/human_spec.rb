require 'rails_helper'

RSpec.describe Human, :type => :model do
  it "can create human" do
    human = FactoryGirl.create(:human)

    expect(human.name).to eq "Time Traveller"
  end

  it "human has default health and weapon" do
    human = FactoryGirl.create(:human)

    h = Human.new

    expect(human.health).to_not be(nil)
    expect(human.weapons).to_not be(nil)
  end
end
