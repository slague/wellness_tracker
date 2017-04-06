FactoryGirl.define do

factory :user do
  census_uid 1
  factory :user_with_goals do
    goals { create_list(:goal, 3) }
  end
    factory :user_with_goal do
    goals { create_list(:goal, 1) }
  end
end

factory :category do
  sequence :name do |n|
    "#{n} category name"
  end
end

factory :week do
  week_number
  start_date Date.today
  end_date (Date.today + 7)
end

factory :week_number do
  name "Week 1"
end

factory :goal do
  sequence :description do |n|
    "#{n} goal description"
  end
  category
  # progress_count 0
  total_goal_count 5
  user
  week
end



end
