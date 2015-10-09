require 'faker'

FactoryGirl.define do
  factory :education_experience do
    school_name { Faker::Name.name[0..200] + ' University' }
    diploma { Faker::Lorem.words(4)[0..130] }
    start_date { Faker::Time.between(15.years.ago, 2.years.ago, :midnight) }
  end
end
