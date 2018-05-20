FactoryBot.define do
  factory :resume do
    sequence(:name) { |n| "#{Faker::Name.name[0...255]}#{n}" }
    association(:user)
  end
end
