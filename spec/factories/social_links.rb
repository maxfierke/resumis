FactoryBot.define do
  factory :social_link do
    network { "instagram" }
    username { Faker::Internet.unique.username }
    url { nil }
    user
  end
end
