require 'rails_helper'

RSpec.describe "time_travellers/index", :type => :view do
  before(:each) do
    assign(:time_travellers, [
      TimeTraveller.create!(
        :name => "Name",
        :damage => 1,
        :health => FactoryGirl.create(:health)
      ),
      TimeTraveller.create!(
        :name => "Name",
        :damage => 1,
        :health => FactoryGirl.create(:health)
      )
    ])
  end

  it "renders a list of time_travellers" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
