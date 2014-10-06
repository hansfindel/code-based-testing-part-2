require 'rails_helper'

RSpec.describe "robots/index", :type => :view do
  before(:each) do
    assign(:robots, [
      Robot.create!(
        :code_name_id => 1
      ),
      Robot.create!(
        :code_name_id => 1
      )
    ])
  end

  it "renders a list of robots" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
