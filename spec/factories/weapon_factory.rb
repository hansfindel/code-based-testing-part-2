FactoryGirl.define do

    factory :gun, class: Weapon do
        name "Gun"
        damage 5
        deterioration 0
        attack_deterioration 5
    end

    factory :rifle, class: Weapon do
        name "Rifle"
        damage 10
        deterioration 0
        attack_deterioration 5
    end

    factory :machine_gun, class: Weapon do
        name "Machine Gun"
        damage 20
        deterioration 0
        attack_deterioration 5
    end

    factory :bazuka, class: Weapon do
        name "Bazuka"
        damage 70
        deterioration 0
        attack_deterioration 5
    end

    factory :nanites_gun, class: Weapon do
        name "Nanites Gun"
        damage 15
        deterioration 0
        attack_deterioration 2
        nanites_damage 5
    end

end