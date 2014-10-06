require 'rails_helper'

RSpec.describe "time_travellers/new", :type => :view do
  before(:each) do
    assign(:time_traveller, TimeTraveller.new(
      :name => "MyString",
      :damage => 1
    ))
  end

  it "renders new time_traveller form" do
    render

    assert_select "form[action=?][method=?]", time_travellers_path, "post" do

      assert_select "input#time_traveller_name[name=?]", "time_traveller[name]"

      assert_select "input#time_traveller_damage[name=?]", "time_traveller[damage]"
    end
  end
end
