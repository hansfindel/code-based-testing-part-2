FactoryGirl.define do

    Robot.create

    factory :robot do
        after(:build) do |roboto, evaluator|
            roboto.code_name = FactoryGirl.create(:code_name)
            gun              = FactoryGirl.create(:gun) # could be affected 
            roboto.health    = FactoryGirl.build(:health)
            roboto.save 
            attach_to_robot_weapon_with_health_value(roboto, gun, 10)
        end
    end

    factory :t_800, class: Robot do
        after(:build) do |roboto, evaluator|
            roboto.code_name = FactoryGirl.create(:T_800)
            gun              = FactoryGirl.create(:rifle) # could be affected 
            roboto.health    = FactoryGirl.create(:health_800)
            roboto.save 
            attach_to_robot_weapon_with_health_value(roboto, gun, 10)
        end
    end

    factory :t_1000, class: Robot do
        after(:build) do |roboto, evaluator|
            roboto.code_name = FactoryGirl.create(:T_1000)
            gun              = FactoryGirl.create(:machine_gun) # could be affected 
            roboto.health    = FactoryGirl.build(:health_1000)
            roboto.save 
            attach_to_robot_weapon_with_health_value(roboto, gun, 10)
        end
    end

    factory :t_x, class: Robot do
        after(:build) do |roboto, evaluator|
            roboto.code_name = FactoryGirl.create(:T_X)
            gun           = FactoryGirl.create(:gun) # could be affected 
            rifle         = FactoryGirl.create(:rifle) # could be affected 
            machine_gun   = FactoryGirl.create(:machine_gun) # could be affected 
            bazuka        = FactoryGirl.create(:bazuka) # could be affected 
            roboto.health = FactoryGirl.build(:health_x)
            # roboto.weapons = [gun, rifle, machine_gun, bazuka]
            attach_to_robot_weapon_with_health_value(roboto, gun, 10)
            attach_to_robot_weapon_with_health_value(roboto, rifle, 15)
            attach_to_robot_weapon_with_health_value(roboto, machine_gun, 20)
            attach_to_robot_weapon_with_health_value(roboto, bazuka, 3)
            roboto.save 
        end
    end

    factory :robot_with_frozen_weapon, class: Robot do
      after(:build) do |roboto|
        roboto.code_name = FactoryGirl.create(:frozen)
        freeze_gun       = FactoryGirl.create(:freeze_gun) # could be affected
        # roboto.weapons = [gun, rifle, machine_gun, bazuka]
        roboto.health = FactoryGirl.build(:health_x)
        attach_to_robot_weapon_with_health_value(roboto, freeze_gun, 10)
        roboto.save
      end
    end

    factory :robot_with_slightly_better_weapon, class: Robot do 
        after(:build) do |roboto, evaluator|
            roboto.health    = FactoryGirl.build(:health_1000)
            roboto.code_name = FactoryGirl.create(:code_name)
            gun              = FactoryGirl.create(:gun) # could be affected 
            roboto.code_name.damage = gun.damage - 1
            attach_to_robot_weapon_with_health_value(roboto, gun, 10)
            roboto.save 
            roboto.code_name.save
        end
    end
    factory :robot_with_bad_weapon, class: Robot do 
        after(:build) do |roboto, evaluator|
            roboto.health    = FactoryGirl.build(:health_1000)
            roboto.code_name = FactoryGirl.create(:code_name)
            gun              = FactoryGirl.create(:gun) # could be affected 
            roboto.code_name.damage = gun.damage + 1
            attach_to_robot_weapon_with_health_value(roboto, gun, 10)
            roboto.save 
            roboto.code_name.save
        end
    end

    factory :unarmed_robot, class: Robot do 
        after(:build) do |roboto, evaluator|
            roboto.health    = FactoryGirl.build(:health_1000)
            roboto.code_name = FactoryGirl.create(:code_name)
            roboto.save 
        end
    end

end

# helper 
def attach_to_robot_weapon_with_health_value(robot, weapon, health_value)
    robot.save 
    health             = Health.create(current: health_value, maximum: health_value)
    rw_instance        = RobotWeapon.new(robot_id: robot.id, weapon_id: weapon.id)
    rw_instance.health = health 
    rw_instance.save
end