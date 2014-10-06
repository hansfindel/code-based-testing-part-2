require 'rails_helper'

RSpec.describe "robots/new", :type => :view, js: true do
  before(:each) do
    @code_name = FactoryGirl.create :code_name
    @gun = FactoryGirl.create :gun
  end

  it "renders new robot form" do
    render

    assert_select "form[action=?][method=?]", robots_path, "post" do

      assert_select "input#robot_code_name_id[name=?]", "robot[code_name_id]"
    end
  end
  # rspec with capybara
  it "create a new robot with 2 weapons" do
    visit new_robot_path
    code_name = @code_name.id
    current_health = 50
    max_health= 50
    within("#new_robot") do
      fill_in 'Code name', :with => code_name
      fill_in 'Current', :with => current_health
      fill_in 'Maximum', :with => max_health
    end

    click_link 'Add a Weapon'
    expect(page).to have_content "Weapon Name"
    click_button 'Create Robot'
    expect(page).to have_content code_name
    expect(page).to have_content current_health
    expect(page).to have_content max_health
    expect(page).to have_content "Weapons Count: #{2}"

  end
end
