require 'rails_helper'

RSpec.describe "weapons/new", :type => :view do
  before(:each) do
    assign(:weapon, Weapon.new(
      :name => "MyString",
      :damage => 1
    ))
  end

  it "renders new weapon form" do
    render

    assert_select "form[action=?][method=?]", weapons_path, "post" do

      assert_select "input#weapon_name[name=?]", "weapon[name]"

      assert_select "input#weapon_damage[name=?]", "weapon[damage]"

      assert_select "input#weapon_recoil_damage[name=?]", "weapon[recoil_damage]"

    end
  end

  it "marks weapons tab" do
    visit new_weapon_path
    find('#robots-tab')[:class].should_not include('active')
    find('#home-tab')[:class].should_not include('active')
    find('#weapons-tab')[:class].should include('active')
    find('#code_names-tab')[:class].should_not include('active')
  end
end
