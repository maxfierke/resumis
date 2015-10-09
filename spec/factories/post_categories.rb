FactoryGirl.define do
  factory :post_category do
    name { Faker::Lorem.words(4)[0..75] }
  end
end
