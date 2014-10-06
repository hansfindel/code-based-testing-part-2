require 'rails_helper'

RSpec.describe "code_names/show", :type => :view do
  before(:each) do
    @code_name = assign(:code_name, CodeName.create!(
      :name => "Name",
      :info_reference => "Info Reference"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Info Reference/)
  end
end
