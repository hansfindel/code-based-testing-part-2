FactoryGirl.define do

    factory :gun, class: Weapon do
        name "Gun"
        damage 5
        technology 5
    end

    factory :rifle, class: Weapon do
        name "Rifle"
        damage 10
        technology 10
    end

    factory :machine_gun, class: Weapon do
        name "Machine Gun"
        damage 20
        technology 20
    end

    factory :bazuka, class: Weapon do
        name "Bazuka"
        damage 70
        technology 70
    end

end