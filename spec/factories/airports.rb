FactoryBot.define do
  factory :origin_airport, class: "Airport" do
    code { "BOS"}
    location { "Boston, MA" }
  end

  factory :destination_airport, class: "Airport" do
    code { "JFK" }
    location { "New York, NY" }
  end
end
