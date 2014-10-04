# == Schema Information
#
# Table name: code_names
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  info_reference :string(255)
#  damage         :integer
#  created_at     :datetime
#  updated_at     :datetime
#  tech           :integer          default(0)
#

require 'rails_helper'

RSpec.describe CodeName, :type => :model do
  context "Factories" do   
    before(:each) do 
        @code_name = FactoryGirl.create(:code_name)
    end
    it ":code_name" do 
      expect(@code_name.id).to be > 0
    end

    it ":should have distinct id if different" do 
      code_name = FactoryGirl.create(:code_name)
      expect(@code_name.id != code_name.id).to be true
    end

    it ":T_800" do 
      code_name = FactoryGirl.create(:T_800)
      expect(code_name.id).to be > 0
    end

    it ":T_1000" do 
      code_name = FactoryGirl.create(:T_1000)
      expect(code_name.id).to be > 0
    end

    it ":T_X" do 
      code_name = FactoryGirl.create(:T_X)
      expect(code_name.id).to be > 0
    end

    it "should not create two different code_names for the same (defined) machine" do 
      # code_name1 = FactoryGirl.create(:T_X)
      # code_name2 = FactoryGirl.create(:T_X)
      # expect(code_name1.id == code_name2.id).to be true
    end

    it "should be the same instance if created with the same name" do
      code_name1 = FactoryGirl.create :code_name, name: "ABC"
      binding.pry
      code_name2 = FactoryGirl.create :code_name, name: "ABC"
      expect(code_name2).to eq(code_name1)
    end

    it "should have a tech value" do
      code_name = FactoryGirl.create(:code_name)
      expect(code_name.tech).not_to be(nil)
    end

    it "should have a tech value greater than or equal to 0" do
      code_name = FactoryGirl.create(:code_name)
      expect(code_name.tech).to be >= 0
    end
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
