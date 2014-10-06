require 'rails_helper'

RSpec.describe "robots/new", :type => :view do
  before(:each) do
    @robot = assign(:robot, Robot.new(
      health: Health.new,
      code_name: CodeName.new)
    )
  end

  it "renders new robot form" do
    render

    assert_select "form[action=?][method=?]", robots_path, "post" do

      #En new debe aparecer el selector de code name
      assert_select "select#robot_code_name_id[name=?]", "robot[code_name_id]"

      #En new debieran aparecer los campos para agregar un nuevo code name
      assert_select "input[name^='robot[code_name_attributes]']", 4

      #En new debieran aparecer los campos para agregar delay de robot
      assert_select "input[name='robot[delay]']"

      #En new debieran aparecer los campos para agregar health
      assert_select "input[name^='robot[health_attributes]']", 2

    end
   end
end
