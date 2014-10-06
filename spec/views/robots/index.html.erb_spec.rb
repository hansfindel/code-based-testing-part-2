require 'rails_helper'

RSpec.describe "robots/index", :type => :view do
  before(:each) do
    @robots = assign(:robots, [FactoryGirl.create(:default_robot),FactoryGirl.create(:t_x)])
  end

  it "renders a list of robots" do
    render
    assert_select "tr>td", :text => @robots[0].code_name_id.to_s, :count => 1
    assert_select "tr>td", :text => @robots[1].code_name_id.to_s, :count => 1
  end
end
