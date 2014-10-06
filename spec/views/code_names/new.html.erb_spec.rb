require 'rails_helper'


RSpec.describe "code_names/new", :type => :view do
  before(:each) do
    assign(:code_name, FactoryGirl.build(:code_name))
  end

  # default rspec view test
  it "renders new code_name form" do
    render

    assert_select "form[action=?][method=?]", code_names_path, "post" do

      assert_select "input#code_name_name[name=?]", "code_name[name]"

      assert_select "input#code_name_info_reference[name=?]", "code_name[info_reference]"

      assert_select "input#code_name_damage[name=?]", "code_name[damage]"

      assert_select "input#code_name_max_health[name=?]", "code_name[max_health]"
    end
  end

  # rspec with capybara 
  it "create a new code_name" do
    visit new_code_name_path
    # visit "code_names/new"
    email = "user@example.com"
    within("#new_code_name") do
      fill_in 'Name', :with => email
      fill_in 'Info reference', :with => 'password-wiki-password'
      fill_in 'Damage', :with => '42'
      fill_in 'Maximum Health', with: '50'
    end
    click_button 'Create Code name'
    expect(page).to have_content email
    expect(page).to have_content "Listing code_names"
  end

  it "marks code_names tab" do
    visit new_code_name_path
    find('#robots-tab')[:class].should_not include('active')
    find('#home-tab')[:class].should_not include('active')
    find('#weapons-tab')[:class].should_not include('active')
    find('#code_names-tab')[:class].should include('active')
  end

end
