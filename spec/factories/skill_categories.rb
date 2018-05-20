FactoryBot.define do
  factory :skill_category do
    sequence(:name) { |n| "#{Faker::Lorem.words(3).join(' ')}#{n}" }
    association(:user)
  end
end
