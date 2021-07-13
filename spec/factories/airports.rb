FactoryBot.define do
  factory :origin_airport, class: "Airport" do
    id { Faker::Number.unique.number(digits: 4) }
    code { "BOS" }
    location { "Boston, MA" }
  end

  factory :destination_airport, class: "Airport" do
    id { Faker::Number.unique.number(digits: 4) }
    code { "JFK" }
    location { "New York, NY" }
  end
end
