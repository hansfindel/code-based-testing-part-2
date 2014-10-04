# == Schema Information
#
# Table name: weapons
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  damage     :integer
#  created_at :datetime
#  updated_at :datetime
#  min_tech   :integer
#

FactoryGirl.define do

    factory :gun, class: Weapon do
        name "Gun"
        damage 5
    end

    factory :rifle, class: Weapon do
        name "Rifle"
        damage 10
    end

    factory :machine_gun, class: Weapon do
        name "Machine Gun"
        damage 20
    end

    factory :bazuka, class: Weapon do
        name "Bazuka"
        damage 70
    end

end
