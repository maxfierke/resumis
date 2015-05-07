require 'faker'

FactoryGirl.define do
  factory :education_experience do
    school_name { Faker::Name.name + ' University' }
    diploma { Faker::Lorem.word }
    start_date { Faker::Time.between(15.years.ago, 2.years.ago, :midnight) }
  end
end
