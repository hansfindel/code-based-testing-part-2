require 'rails_helper'

RSpec.describe "time_travellers/edit", :type => :view do
  before(:each) do
    @time_traveller = assign(:time_traveller, TimeTraveller.create!(
      :name => "MyString",
      :damage => 1,
      :health => FactoryGirl.create(:health)
    ))
  end

  it "renders the edit time_traveller form" do
    render

    assert_select "form[action=?][method=?]", time_traveller_path(@time_traveller), "post" do

      assert_select "input#time_traveller_name[name=?]", "time_traveller[name]"

      assert_select "input#time_traveller_damage[name=?]", "time_traveller[damage]"
    end
  end
end
