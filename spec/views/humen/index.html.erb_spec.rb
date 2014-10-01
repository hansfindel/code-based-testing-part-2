require 'rails_helper'

RSpec.describe "humen/index", :type => :view do
  before(:each) do
    assign(:humen, [
      Human.create!(
        :name => "Name",
        :damage => 1
      ),
      Human.create!(
        :name => "Name",
        :damage => 1
      )
    ])
  end

  it "renders a list of humen" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
