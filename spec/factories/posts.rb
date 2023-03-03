FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "#{Faker::Lorem.sentence(word_count: 2)[0...55]}#{n}" }
    body { Faker::Markdown.sandwich(sentences: 6, repeat: 3) }
    association(:user)
  end
end
