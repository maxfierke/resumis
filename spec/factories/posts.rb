FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "#{Faker::Lorem.sentence(word_count: 2)[0...55]}#{n}" }
    association(:user)
  end
end
