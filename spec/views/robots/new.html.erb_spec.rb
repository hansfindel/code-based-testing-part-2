require 'rails_helper'

RSpec.describe "robots/new", :type => :view do
  before(:each) do
    assign(:robot, Robot.new(
      :code_name => CodeName.new,
      :health => Health.new
    ))
  end

  it "renders new robot form" do

    render

    assert_select "form[action=?][method=?]", robots_path, "post" do



      assert_select "input#robot_code_name_id[name=?]", "robot[code_name_attributes][id]"
      assert_select "input#robot_code_name_name[name=?]", "robot[code_name_attributes][name]"
      assert_select "input#robot_code_name_info_reference[name=?]", "robot[code_name_attributes][info_reference]"
      assert_select "input#robot_code_name_damage[name=?]", "robot[code_name_attributes][damage]"

    end
  end
end
