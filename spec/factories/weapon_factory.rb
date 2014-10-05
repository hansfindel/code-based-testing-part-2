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

    factory :no_recoil, class: Weapon do
        name "Laser Beam"
        damage 100
        recoil 0 
    end

    factory :full_recoil, class: Weapon do
        name "Laser Beam"
        damage 0
        recoil 100 
    end

    factory :mid_recoil, class: Weapon do
        name "Laser Beam"
        damage 50
        recoil 50 
    end

    factory :frozen_gun, class: Weapon do
        name "Frozen Laser Beam"
        damage 50
        freezer true 
    end

end