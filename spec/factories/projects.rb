FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "#{Faker::Lorem.sentence(2)}#{n}" }
    start_date { Faker::Time.between(15.years.ago, 2.years.ago, :midnight) }
    end_date { Faker::Time.between(2.years.ago, Time.now, :midnight) }
    association(:user)
    association(:project_status)
  end
end
