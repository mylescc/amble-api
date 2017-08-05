FactoryGirl.define do
  factory :step_day do
    steps 1
    date "2017-05-08"
    association :user
  end
end
