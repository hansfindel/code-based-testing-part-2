require "rails_helper"

RSpec.describe RobotsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/robots").to route_to("robots#index")
    end

    it "routes to #new" do
      expect(:get => "/robots/new").to route_to("robots#new")
    end

    it "routes to #show" do
      expect(:get => "/robots/1").to route_to("robots#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/robots/1/edit").to route_to("robots#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/robots").to route_to("robots#create")
    end

    it "routes to #update" do
      expect(:put => "/robots/1").to route_to("robots#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/robots/1").to route_to("robots#destroy", :id => "1")
    end

  end
end
