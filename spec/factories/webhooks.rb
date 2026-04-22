FactoryBot.define do
  factory :webhook do
    association(:user)
    name { Faker::App.unique.name }
    url { "https://example.com/hooks/deploy" }
    resource_types { %w[post project] }
    enabled { true }

    trait :disabled do
      enabled { false }
    end

    trait :all_resources do
      resource_types { Webhook::RESOURCE_TYPES }
    end
  end
end
