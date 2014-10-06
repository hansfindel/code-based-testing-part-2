FactoryGirl.define do

    factory :time_traveller do
        after(:build) do |t_traveller, evaluator|
            t_traveller.name = "Viajero"
            t_traveller.damage = 5
            gun              = FactoryGirl.create(:gun) # could be affected 
            t_traveller.health    = FactoryGirl.build(:health)
            t_traveller.save 
            attach_to_traveller_weapon_with_health_value(t_traveller, gun, 10)
        end
    end

    factory :kyle_reese, class: TimeTraveller do
        after(:build) do |t_traveller, evaluator|
            t_traveller.name = "Kyle Reese"
            t_traveller.damage = 5
            t_traveller.health    = FactoryGirl.create(:health)
            gun           = FactoryGirl.create(:gun) # could be affected 
            rifle         = FactoryGirl.create(:rifle) # could be affected 
            machine_gun   = FactoryGirl.create(:machine_gun) # could be affected 
            bazuka        = FactoryGirl.create(:bazuka) # could be affected 
            # roboto.weapons = [gun, rifle, machine_gun, bazuka]
            attach_to_traveller_weapon_with_health_value(t_traveller, gun, 10)
            attach_to_traveller_weapon_with_health_value(t_traveller, rifle, 15)
            attach_to_traveller_weapon_with_health_value(t_traveller, machine_gun, 20)
            attach_to_traveller_weapon_with_health_value(t_traveller, bazuka, 3)
            t_traveller.save 
        end
    end

    factory :human_with_slightly_better_weapon, class: TimeTraveller do 
        after(:build) do |traveller, evaluator|
            traveller.health    = FactoryGirl.build(:health_1000)
            traveller.name = "Jack BigGun"
            gun              = FactoryGirl.create(:gun) # could be affected 
            traveller.damage = gun.damage - 1
            attach_to_traveller_weapon_with_health_value(traveller, gun, 10)
            traveller.save 
        end
    end
    factory :human_with_bad_weapon, class: TimeTraveller do 
        after(:build) do |traveller, evaluator|
            traveller.health    = FactoryGirl.build(:health_1000)
            traveller.name = "Mike Slingshot"
            gun              = FactoryGirl.create(:gun) # could be affected 
            traveller.damage = gun.damage + 1
            attach_to_traveller_weapon_with_health_value(traveller, gun, 10)
            traveller.save 
        end
    end

    factory :unarmed_human, class: TimeTraveller do 
        after(:build) do |t_traveller, evaluator|
            t_traveller.name = "Jhonn Unarmed"
            t_traveller.damage = 7
            t_traveller.health    = FactoryGirl.build(:health)
            t_traveller.save 
        end
    end

    factory :shooter_with_recoil, class: TimeTraveller do 
        after(:build) do |t_traveller, evaluator|
            t_traveller.name = "Allan Backfire"
            t_traveller.damage = 1
            t_traveller.health    = FactoryGirl.build(:health)
            gun              = FactoryGirl.create(:with_recoil) # could be affected 
            attach_to_traveller_weapon_with_health_value(t_traveller, gun, 15)
            t_traveller.save 
        end
    end

end

# helper 
def attach_to_traveller_weapon_with_health_value(traveller, weapon, health_value)
    traveller.save 
    health             = Health.create(current: health_value, maximum: health_value)
    tw_instance        = TimeTravellerWeapon.new(time_traveller_id: traveller.id, weapon_id: weapon.id)
    tw_instance.health = health 
    tw_instance.save
end