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

    context "Max Health" do
      it "should not create a code_name without max_health" do
        code_name = CodeName.create(name:"name",info_reference:"/wiki/",damage:5)
        expect(code_name.id).to be nil
      end

      it "should not create a code_name with max_health <= 0" do
        code_name = CodeName.create(name:"name",info_reference:"/wiki/",damage:5,max_health:-1)
        expect(code_name.id).to be nil
      end

      it "should create a code_name with a valid max_health" do
        code_name = CodeName.create(name:"name",info_reference:"/wiki/",damage:5,max_health:10)
        expect(code_name.id).to be > 0
      end
    end
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
