FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence(2)[0...60] }
    association(:user)
  end
end
