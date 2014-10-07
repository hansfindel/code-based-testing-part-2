require 'rails_helper'

RSpec.describe "robots/new", :type => :view do

  context "No weapon" do
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

  context "has a weapon" do
    before(:each) do
      robot = Robot.new(code_name_id: 1)
      FactoryGirl.create :bazuka
      @weapon = FactoryGirl.create :gun
      robot.robot_weapons << RobotWeapon.new(weapon: @weapon, health: Health.new(current: 1, maximum: 5))
      assign(:robot, robot)
    end

    it "renders weapon names" do
      render
      expect(rendered).to match /Gun/
    end

    it "renders weapon selectors" do
      render
      assert_select "option" do
        assert_select "[selected=selected][value=?]", @weapon.id
      end
    end
  end
end
