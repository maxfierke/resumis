FactoryBot.define do
  factory :project_status do
    sequence(:name) { |m| "#{Faker::Lorem.word}#{m}" }
    association(:user)
  end
end
