require 'rails_helper'

RSpec.describe "robots/new", :type => :view do
  
  context "default" do
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
  end

  context "nested_forms" #Esto debiera ir en el controller???
    it "should create robot and a weapon" do 
      expect(Robot.count).to be(0)

      expect(Robot.count).to be(1)
    end
  end


  #test "should create company and first user" do
    #assert_difference('Company.count') do
    #  assert_difference('User.count') do
    #    post :create, company: { 
    #      city: @company.city, 
    #      name: @company.name, 
    #      users_attributes: {
    #        user: {name: @user.name, email: @user.email}, 
    #        user: {name: @user.name, email: @user.email}
    #      }
    #    }
    #  end
    #end
    #assert_redirected_to company_path(assigns(:company))
  #end
end
