require 'rails_helper'

RSpec.describe "code_names/index", :type => :view do
  before(:each) do
    assign(:code_names, [
      CodeName.create!(
        :name => "Name",
        :info_reference => "Info Reference/wiki/",
        :damage => 10,
        :max_health => 10
      ),
      CodeName.create!(
        :name => "Name1",
        :info_reference => "Info Reference/wiki/",
        :damage => 10,
        :max_health => 10
      )
    ])
  end

  it "renders a list of code_names" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 1
    assert_select "tr>td", :text => "Name1".to_s, :count => 1
    assert_select "tr>td", :text => "Info Reference/wiki/".to_s, :count => 2
  end

  it "marks code_names tab" do
    visit code_names_path
    find('#robots-tab')[:class].should_not include('active')
    find('#home-tab')[:class].should_not include('active')
    find('#weapons-tab')[:class].should_not include('active')
    find('#code_names-tab')[:class].should include('active')
  end
end
