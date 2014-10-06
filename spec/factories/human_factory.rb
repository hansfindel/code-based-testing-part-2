FactoryGirl.define do
  factory :human, class: Human do
    after(:build) do |humano, evaluator|
      humano.human_code_name = FactoryGirl.create(:TimeTraveller)
      gun              = FactoryGirl.create(:gun) # could be affected
      gun.humans << humano
      gun.save
      humano.health    = FactoryGirl.build(:health)
      humano.save

    end
  end



end