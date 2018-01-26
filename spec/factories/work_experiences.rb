FactoryBot.define do
  factory :work_experience do
    organization { Faker::Name.name[0...255] + ' Inc.' }
    position { Faker::Lorem.words(4)[0...255] }
    start_date { Faker::Time.between(15.years.ago, 2.years.ago, :midnight) }
    end_date { Faker::Time.between(2.years.ago, Time.now, :midnight) }
  end

end
