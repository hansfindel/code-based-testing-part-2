require 'rails_helper'

RSpec.describe "robots/new", :type => :view do
  
  before(:each) do
    assign(:robot, Robot.new(
      :code_name_id => 1
    ))
  end

  it "renders new robot form" do
    render
    assert_select "form[action=?][method=?]", robots_path, "post" do
      assert_select "input#robot_code_name_id[name=?]", "robot[code_name_id]"
    end
  end

  #dlarrain
  #visita la pagina de nuevo robor, hace click en Add a Weapon, y se verifica que se muestre el nuevo formulario
  it "accept nested forms", js: true do
    visit new_robot_path
    expect(page).to have_content 'New robot'
    expect(page).to have_link('Add a Weapon')
    click_link('Add a Weapon')
    expect(page).to have_content 'Weapon Name'
  end

end
