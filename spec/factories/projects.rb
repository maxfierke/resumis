FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "#{Faker::Lorem.sentence(word_count: 2)}#{n}" }
    start_date { Faker::Time.between_dates(from: 15.years.ago, to: 2.years.ago, period: :midnight) }
    end_date { Faker::Time.between_dates(from: 2.years.ago, to: Time.now, period: :midnight) }
    association(:user)
    association(:project_status)
  end
end
