FactoryBot.define do
  factory :resume do
    name { Faker::Name.name[0...255] }
    association(:user)
  end
end
