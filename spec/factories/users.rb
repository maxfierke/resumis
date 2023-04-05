FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    sequence(:subdomain) { |n| "#{Faker::Internet.domain_word}#{n}" }
    password { Faker::Internet.password }
    tagline { Faker::Lorem.sentence }
    homepage_url { Faker::Internet.url(path: '') }
    blog_url { Faker::Internet.url(path: '/blog') }

    trait :admin do
      admin { true }
    end

    trait :disabled do
      disabled_at { 5.minutes.ago }
    end

    after(:create) do |user|
      CreateUserDefaultsJob.new.perform(user)
    end
  end
end
