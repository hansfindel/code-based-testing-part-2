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

    factory :with_recoil, class: Weapon do
        name "BackFiring Gun"
        damage 100
        recoil 10
    end

    factory :high_tech, class: Weapon do
        name "Raygun"
        damage 99
        tech_level 10
    end

end