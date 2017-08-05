FactoryGirl.define do
  factory :walk do
    association :user
    association :route

    trait :completed do
      completed_at 1.day.ago
    end
  end
end
