FactoryBot.define do
  factory :project_category do
    name { Faker::Lorem.words(4)[0..75] }
    association(:user)
  end
end
