# == Schema Information
#
# Table name: code_names
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  info_reference   :string(255)
#  damage           :integer
#  created_at       :datetime
#  updated_at       :datetime
#  technology_level :integer
#

FactoryGirl.define do
    sequence(:name) {|n| "Robot-#{n}"}
    factory :code_name do
        name
        damage 5
        info_reference "wiki"
    end

    factory :T_800, class: CodeName do
        name "T-800"
        damage 6
        info_reference "http://en.wikipedia.org/wiki/Terminator_(character)"
    end

    factory :T_1000, class: CodeName do
        name "T-1000"
        damage 10
        info_reference "http://en.wikipedia.org/wiki/T-1000"
    end

    factory :T_X, class: CodeName do
        name "T-X"
        damage 15
        info_reference "http://en.wikipedia.org/wiki/T-X"
    end

end
