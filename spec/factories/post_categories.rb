require 'faker'

FactoryGirl.define do
  factory :post_category do
    name { Faker::Name.name }
  end
end
