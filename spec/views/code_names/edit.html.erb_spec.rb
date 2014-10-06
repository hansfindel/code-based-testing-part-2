require 'rails_helper'

RSpec.describe "code_names/edit", :type => :view do
  before(:each) do
    @code_name = assign(:code_name, CodeName.create!(
      :name => "MyString",
      :info_reference => "MyString"
    ))
  end

  it "renders the edit code_name form" do
    render

    assert_select "form[action=?][method=?]", code_name_path(@code_name), "post" do

      assert_select "input#code_name_name[name=?]", "code_name[name]"

      assert_select "input#code_name_info_reference[name=?]", "code_name[info_reference]"
    end
  end
end
