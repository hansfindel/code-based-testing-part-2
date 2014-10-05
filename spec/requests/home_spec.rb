require 'rails_helper'

RSpec.describe "Home", :type => :request do
  describe "GET /" do

    it "Page is online" do
      get root_path
      expect(response.status).to eq(200)
    end
    it "Root active" do
      visit root_path
      expect(page).to have_selector( "li.active") do
        have_selector('a', :content => 'Home')
      end
    end
    it "Robots active" do
      visit new_robot_path
      expect(page).to have_selector( "li.active") do
        have_selector('a', :content => 'Robots')
      end
    end
    it "Weapons active" do
      visit new_weapon_path
      expect(page).to have_selector( "li.active") do
        have_selector('a', :content => 'Weapons')
      end
    end
  end
end
