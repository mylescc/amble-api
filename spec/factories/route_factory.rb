FactoryGirl.define do
  factory :route do
    name { Faker::Address.city }
    description { Faker::Lorem.sentence }
    distance_km { Faker::Number.number(3) }
    distance_steps { Faker::Number.number(7) }
  end
end
