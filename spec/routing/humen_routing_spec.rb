require "rails_helper"

RSpec.describe HumenController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/humen").to route_to("humen#index")
    end

    it "routes to #new" do
      expect(:get => "/humen/new").to route_to("humen#new")
    end

    it "routes to #show" do
      expect(:get => "/humen/1").to route_to("humen#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/humen/1/edit").to route_to("humen#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/humen").to route_to("humen#create")
    end

    it "routes to #update" do
      expect(:put => "/humen/1").to route_to("humen#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/humen/1").to route_to("humen#destroy", :id => "1")
    end

  end
end
