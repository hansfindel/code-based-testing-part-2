require 'rails_helper'

RSpec.describe "robots/show", :type => :view do
  before(:each) do
    @robot = assign(:robot, FactoryGirl.create(:default_robot))

  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
  end
end
