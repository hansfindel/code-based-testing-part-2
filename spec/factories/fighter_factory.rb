FactoryGirl.define do

    factory :fighter_bruce_lee, class: Fighter do
    	strengh 3
		speed 10
		combo_rate 0.9
		ki 4
        after(:build) do |fighter, evaluator|
            fighter.human	  = FactoryGirl.build(:human_bruce_lee)
            fighter.save 
        end
    end

    factory :fighter_goku, class: Fighter do
    	strengh 300
		speed 100
		combo_rate 1
		ki 4000
        after(:build) do |fighter, evaluator|
            fighter.human	  = FactoryGirl.build(:human_goku)
            fighter.save 
        end
    end

end