FactoryBot.define do
  factory :project_status do
    name { Faker::Lorem.word }
    association(:user)
  end
end
