require "rails_helper"

RSpec.describe TimeTravellersController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/time_travellers").to route_to("time_travellers#index")
    end

    it "routes to #new" do
      expect(:get => "/time_travellers/new").to route_to("time_travellers#new")
    end

    it "routes to #show" do
      expect(:get => "/time_travellers/1").to route_to("time_travellers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/time_travellers/1/edit").to route_to("time_travellers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/time_travellers").to route_to("time_travellers#create")
    end

    it "routes to #update" do
      expect(:put => "/time_travellers/1").to route_to("time_travellers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/time_travellers/1").to route_to("time_travellers#destroy", :id => "1")
    end

  end
end
