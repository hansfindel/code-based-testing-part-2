require 'rails_helper'

RSpec.describe "time_travellers/show", :type => :view do
  before(:each) do
    @time_traveller = assign(:time_traveller, TimeTraveller.create!(
      :name => "Name",
      :damage => 1,
      :health => FactoryGirl.create(:health)
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/1/)
  end
end
