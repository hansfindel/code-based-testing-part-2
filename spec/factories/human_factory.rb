FactoryGirl.define do

    factory :human_bruce_lee, class: Human do
        name "Bruce Lee"
         after(:build) do |human, evaluator|
            human.health    = FactoryGirl.build(:health_super_human)
            human.save 
        end
    end

    factory :human_goku, class: Human do
        name "Goku"
         after(:build) do |human, evaluator|
            human.health    = FactoryGirl.build(:health_saya)
            human.save 
        end
    end

end