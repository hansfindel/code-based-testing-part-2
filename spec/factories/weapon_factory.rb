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
    factory :mega_bazuka, class: Weapon do
        name "Mega Bazuka"
        damage 100
    end
    factory :ice_cannon, class: Weapon do
        name "Ice Cannon"
        damage 50
        secondary_effect "freeze"
    end

end