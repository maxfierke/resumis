FactoryBot.define do
  factory :access_grant, class: Doorkeeper::AccessGrant do
    sequence(:resource_owner_id) { |n| n }
    application
    redirect_uri { "https://app.com/callback" }
    revoked_at { nil }
    expires_in { 900 }
    scopes { "public" }

    trait :limitless do
      expires_in { nil }
    end

    trait :expired do
      expires_in { -100 }
    end

    trait :revoked do
      revoked_at { DateTime.yesterday.beginning_of_day }
    end
  end
end
