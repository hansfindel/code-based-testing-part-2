FactoryGirl.define do
    sequence(:name) {|n| "Robot-#{n}"}
    factory :code_name do
        name
        damage 5
        info_reference "wiki"
        max_health 50
    end

    factory :T_800, class: CodeName do
        name "T-800"
        damage 6
        info_reference "http://en.wikipedia.org/wiki/Terminator_(character)"
        max_health 80
    end

    factory :T_1000, class: CodeName do
        name "T-1000"
        damage 10
        info_reference "http://en.wikipedia.org/wiki/T-1000"
        max_health 100
    end

    factory :T_X, class: CodeName do
        name "T-X"
        damage 15
        info_reference "http://en.wikipedia.org/wiki/T-X"
        max_health 120
    end

    factory :min_code do
        name "min_health"
        damage 5
        info_reference "wiki"
        max_health 1
    end

end