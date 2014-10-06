FactoryGirl.define do

    factory :gun, class: Weapon do
        name "Gun"
        damage 5
        recoil 1
    end

    factory :rifle, class: Weapon do
        name "Rifle"
        damage 10
        recoil 2
    end

    factory :machine_gun, class: Weapon do
        name "Machine Gun"
        damage 20
        recoil 3
    end

    factory :bazuka, class: Weapon do
        name "Bazuka"
        damage 70
        recoil 4
    end

end