FactoryGirl.define do
  factory :type do
    name { Faker::Lorem.word }
    slug { Faker::Lorem.word }
  end
end
