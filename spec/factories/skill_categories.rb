FactoryBot.define do
  factory :skill_category do
    name { Faker::Lorem.words(3) }
    association(:user)
  end
end
