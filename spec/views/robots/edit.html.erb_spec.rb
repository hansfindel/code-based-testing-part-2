require 'rails_helper'

RSpec.describe "robots/edit", :type => :view do
  before(:each) do
    @robot = assign(:robot, Robot.create!(
      :code_name_id => 1
    ))
  end

  it "renders the edit robot form" do
    render

    assert_select "form[action=?][method=?]", robot_path(@robot), "post" do

      assert_select "input#robot_code_name_id[name=?]", "robot[code_name_id]"
    end
  end
end
