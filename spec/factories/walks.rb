FactoryGirl.define do
  factory :walk do
    association :user
    association :route
  end
end
