require 'rails_helper'

RSpec.describe "robots/new", :type => :view do
  before(:each) do
    assign(:robot, Robot.new(
      :code_name_id => 1
    ))
  end

  it "renders new robot form" do
    render

    assert_select "form[action=?][method=?]", robots_path, "post" do

      assert_select "input#robot_code_name_id[name=?]", "robot[code_name_id]"
    end
  end
end
