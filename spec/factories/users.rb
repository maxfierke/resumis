FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    subdomain { Faker::Internet.domain_word }
    password { Faker::Internet.password }

    trait :admin do
      admin true
    end
  end
end
