# tests_helper_spec
require 'rails_helper'

RSpec.describe "Tests" do
	it "should be a valid test" do 
		expect(4).to be_a_multiple_of(2)
	end  
	it "should be an invalid test" do 
		expect(4).not_to be_a_multiple_of(3)
	end  
end
