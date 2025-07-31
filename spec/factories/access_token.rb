FactoryBot.define do
  factory :access_token, class: Doorkeeper::AccessToken do
    resource_owner_id { create(:user).id }
    application
    revoked_at { nil }
    expires_in { 900 }

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
