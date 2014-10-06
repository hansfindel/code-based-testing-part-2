require 'rails_helper'

RSpec.describe CodeName, :type => :model do
  context "Factories" do

    before(:each) do 
        @code_name = FactoryGirl.create(:code_name)
    end

    it ":singleton with factory" do
      a = FactoryGirl.create(:T_800)
      b = FactoryGirl.create(:T_800)

      expect(a == b).to be true

      a = FactoryGirl.create(:T_X)
      b = FactoryGirl.create(:T_X)

      expect(a == b).to be true

      a = FactoryGirl.create(:T_1000)
      b = FactoryGirl.create(:T_1000)

      expect(a == b).to be true
    end

    it "singleton with instantiation" do
      a = CodeName.new({name: "T_800", damage: 1, info_reference: "http://www.wikipedia.com/yadayada", max_health:10})
      a.save!
      b = CodeName.new({name: "T_800", damage: 1, info_reference: "http://www.wikipedia.com/yadayada", max_health:10})

      expect(a == b).to be true
    end

=begin
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
=end



  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
