require 'rails_helper'

RSpec.describe TimeTravellerWeapon, :type => :model do
  #pending "add some examples to (or delete) #{__FILE__}"

  context "initialization" do 
    it "should have a health" do 
      traveller_weapon = TimeTravellerWeapon.new
      expect(traveller_weapon).to check_health_at_empty_initialization 
    end
    it "should have a (custom)health" do 
      traveller_weapon = TimeTravellerWeapon.new
      expect(traveller_weapon).to check_attr_at_empty_initialization(:health)
    end
  end

end
