require 'rails_helper'

RSpec.describe "CodeNames", :type => :request do
  describe "GET /code_names" do
    it "works! (now write some real specs)" do
      get code_names_path
      expect(response.status).to be(200)
    end
  end
end
