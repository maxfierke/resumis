FactoryBot.define do
  factory :skill do
    name { Faker::Lorem.words(3) }
    association(:user)
    association(:skill_category)
  end
end
