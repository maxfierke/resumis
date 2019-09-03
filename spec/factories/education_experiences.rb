FactoryBot.define do
  factory :education_experience do
    school_name { Faker::Name.name[0..200] + ' University' }
    diploma { Faker::Lorem.words(number: 4)[0..130].join(' ') }
    start_date { Faker::Time.between_dates(from: 15.years.ago, to: 2.years.ago, period: :midnight) }
    end_date { Faker::Time.between_dates(from: 2.years.ago, to: Time.now, period: :midnight) }
    association(:user)
  end
end
