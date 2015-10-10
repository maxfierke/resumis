FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.sentence(2)[0..60] }
  end
end
