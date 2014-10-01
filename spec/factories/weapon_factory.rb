FactoryGirl.define do

    factory :gun, class: Weapon do
        name "Gun"
        damage 5
        freezes? false
    end

    factory :rifle, class: Weapon do
        name "Rifle"
        damage 10
        freezes? false
    end

    factory :machine_gun, class: Weapon do
        name "Machine Gun"
        damage 20
        freezes? false
    end

    factory :bazuka, class: Weapon do
        name "Bazuka"
        damage 70
        freezes? false
    end

    factory :freeze_gun, class Weapon do
      name "Freeze Gun"
      damage 100
      freezes? true
    end

end
