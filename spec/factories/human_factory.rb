FactoryGirl.define do

    factory :human_bruce_lee, class: Human do
         after(:build) do |human, evaluator|
            human.name      = "Bruce Lee"
            human.health    = FactoryGirl.build(:health_super_human)
            human.save 
        end
    end

    factory :human_goku, class: Human do
         after(:build) do |human, evaluator|
            human.name      = "Goku"
            human.health    = FactoryGirl.build(:health_saya)
            human.save 
        end
    end

end