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

    factory :freezer, class: Weapon do
      name "Freezer"
      damage 20
      effect "freeze"
    end

    factory :flamethrower, class: Weapon do
      name "Flamethrower"
      damage 30
      effect "burn"
    end

end