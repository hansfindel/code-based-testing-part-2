FactoryGirl.define do

    factory :gun, class: Weapon do
        name "Gun"
        damage 5
    end

    factory :freeze_gun, class: Weapon do
      name "Freeze Gun"
      damage 100
      side_effect "freezes"
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
