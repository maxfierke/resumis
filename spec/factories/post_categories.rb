FactoryBot.define do
  factory :post_category do
    sequence(:name) { |n| "#{Faker::Lorem.words(number: 4)[0..75].join(' ')}#{n}" }
    association(:user)
  end
end
