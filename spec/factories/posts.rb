require 'faker'

FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.sentence(2) }
  end
end
