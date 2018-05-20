FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "#{Faker::Lorem.sentence(2)[0...55]}#{n}" }
    association(:user)
  end
end
