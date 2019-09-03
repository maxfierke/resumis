FactoryBot.define do
  factory :work_experience do
    organization { Faker::Name.name[0...255] + ' Inc.' }
    position { Faker::Lorem.words(number: 4)[0...255] }
    start_date { Faker::Time.between_dates(from: 15.years.ago, to: 2.years.ago, period: :midnight) }
    end_date { Faker::Time.between_dates(from: 2.years.ago, to: Time.now, period: :midnight) }
    association(:user)
  end
end
