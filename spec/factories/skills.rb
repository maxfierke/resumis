FactoryBot.define do
  factory :skill do
    name { Faker::Lorem.words(3) }
  end
end
