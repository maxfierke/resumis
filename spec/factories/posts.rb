FactoryBot.define do
  factory :post do
    sequence(:title) { |n| "#{Faker::Lorem.sentence(word_count: 2)[0...55]}#{n}" }
    body { Faker::Markdown.sandwich(sentences: 6, repeat: 3) }
    association(:user)

    trait :published do
      published { true }
      published_on { rand(1..24).months.ago }
    end

    trait :with_categories do
      transient do
        category_count { rand(5) }
      end

      after(:build) do |post, evaluator|
        post.post_categories = build_list(:post_category, evaluator.category_count)
      end
    end
  end
end
