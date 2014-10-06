FactoryGirl.define do

    factory :gun, class: Weapon do
        name "Gun"
        damage 5
        recoil_damage 1
    end

    factory :rifle, class: Weapon do
        name "Rifle"
        damage 10
        recoil_damage 5
    end

    factory :machine_gun, class: Weapon do
        name "Machine Gun"
        damage 20
        recoil_damage 10
    end

    factory :bazuka, class: Weapon do
        name "Bazuka"
        damage 70
        recoil_damage 20
    end

end