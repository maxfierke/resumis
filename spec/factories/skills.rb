FactoryBot.define do
  factory :skill do
    sequence(:name) { |n| "#{Faker::Lorem.words(number: 3).join(' ')}#{n}" }
    association(:user)
    association(:skill_category)
  end
end
