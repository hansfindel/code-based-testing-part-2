require 'rails_helper'

RSpec.describe "humen/edit", :type => :view do
  before(:each) do
    @human = assign(:human, Human.create!(
      :name => "MyString",
      :damage => 1
    ))
  end

  it "renders the edit human form" do
    render

    assert_select "form[action=?][method=?]", human_path(@human), "post" do

      assert_select "input#human_name[name=?]", "human[name]"

      assert_select "input#human_damage[name=?]", "human[damage]"
    end
  end
end
