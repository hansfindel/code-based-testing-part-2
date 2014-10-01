require 'rails_helper'

RSpec.describe "humen/show", :type => :view do
  before(:each) do
    @human = assign(:human, Human.create!(
      :name => "Name",
      :damage => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/1/)
  end
end
