require 'rails_helper'

RSpec.describe "weapons/show", :type => :view do
  before(:each) do
    @weapon = assign(:weapon, Weapon.create!(
      :name => "Name",
      :damage => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/1/)
  end
end
