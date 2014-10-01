require 'rails_helper'

RSpec.describe "humen/new", :type => :view do
  before(:each) do
    assign(:human, Human.new(
      :name => "MyString",
      :damage => 1
    ))
  end

  it "renders new human form" do
    render

    assert_select "form[action=?][method=?]", humen_path, "post" do

      assert_select "input#human_name[name=?]", "human[name]"

      assert_select "input#human_damage[name=?]", "human[damage]"
    end
  end
end
