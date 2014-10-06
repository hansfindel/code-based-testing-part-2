require 'rails_helper'

RSpec.describe "robots/edit", :type => :view do
  before(:each) do
    @robot = assign(:robot, FactoryGirl.create(:robot))
  end

  it "renders the edit robot form" do
    render

    assert_select "form[action=?][method=?]", robot_path(@robot), "post" do

      #En edit debe aparecer el selector de code name
      assert_select "select#robot_code_name_id[name=?]", "robot[code_name_id]"

      #En edit no debieran aparecer los campos para agregar un nuevo code name
      assert_select "input[name^='robot[code_name_attributes]']", false

    end
   end
end
