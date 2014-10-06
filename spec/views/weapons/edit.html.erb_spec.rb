require 'rails_helper'

RSpec.describe "weapons/edit", :type => :view do
  before(:each) do
    @weapon = assign(:weapon, Weapon.create!(
      :name => "MyString",
      :damage => 1
    ))
  end

  it "renders the edit weapon form" do
    render

    assert_select "form[action=?][method=?]", weapon_path(@weapon), "post" do

      assert_select "input#weapon_name[name=?]", "weapon[name]"

      assert_select "input#weapon_damage[name=?]", "weapon[damage]"
    end
  end
end
