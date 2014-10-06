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

      assert_select "select#robot_code_name_id[name=?]", "robot[code_name_id]"
      assert_select "a#code_name_link"
    end
  end

  feature "dynamic form" do
    scenario 'User clicked code_name_link', js:true do
      visit new_robot_path
      find("#code_name_link").click
      expect(page).to have_css "#select_codename_link"
      expect(page).to have_css "#code_name_fields_form"
      expect(page).to have_selector('#code_name_id_select', visible: false)
    end

    scenario 'User clicked code_name_link and select_codename_link', js:true do
      visit new_robot_path
      find("#code_name_link").click
      find("#select_codename_link").click
      expect(page).to have_selector('#code_name_id_select', visible: true)
      expect(page).not_to have_css "#select_codename_link"
      expect(page).not_to have_css "#code_name_fields_form"
      expect(page).to have_css "#code_name_link" 
    end
  end

  it "marks robot tab" do
    visit new_robot_path
    find('#robots-tab')[:class].should include('active')
    find('#home-tab')[:class].should_not include('active')
    find('#weapons-tab')[:class].should_not include('active')
    find('#code_names-tab')[:class].should_not include('active')
  end
end
