FactoryGirl.define do

    factory :gun, class: Weapon do
        name "Gun"
        damage 5
        tech_need 1
        recoil 0
    end

    factory :rifle, class: Weapon do
        name "Rifle"
        damage 10
        tech_need 1
        recoil 1
    end

    factory :machine_gun, class: Weapon do
        name "Machine Gun"
        damage 20
        tech_need 3
        recoil 2
    end

    factory :bazuka, class: Weapon do
        name "Bazuka"
        damage 70
        tech_need 2
        recoil 5
    end

end