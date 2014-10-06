require 'rails_helper'

RSpec.describe "TimeTravellers", :type => :request do
  describe "GET /time_travellers" do
    it "works! (now write some real specs)" do
      get time_travellers_path
      expect(response.status).to be(200)
    end
  end
end
