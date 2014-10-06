FactoryGirl.define do

    factory :health do
        current 50
        maximum 50
    end

    factory :health_800, class: Health do
        current 80
        maximum 80
    end

    factory :health_1000, class: Health do
        current 100
        maximum 100
    end

    factory :health_x, class: Health do
        current 120
        maximum 120
    end

end