require 'rails_helper'

RSpec.describe "code_names/index", :type => :view do
  before(:each) do
    assign(:code_names, [
      CodeName.create!(
        :name => "Name",
        :info_reference => "Info Reference"
      ),
      CodeName.create!(
        :name => "Name",
        :info_reference => "Info Reference"
      )
    ])
  end

  it "renders a list of code_names" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Info Reference".to_s, :count => 2
  end
end
