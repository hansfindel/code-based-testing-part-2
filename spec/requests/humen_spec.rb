require 'rails_helper'

RSpec.describe "Humen", :type => :request do
  describe "GET /humen" do
    it "works! (now write some real specs)" do
      get humen_path
      expect(response.status).to be(200)
    end
  end
end
