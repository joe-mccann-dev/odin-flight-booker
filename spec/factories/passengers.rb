FactoryBot.define do
  factory :passenger do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
  end
end
