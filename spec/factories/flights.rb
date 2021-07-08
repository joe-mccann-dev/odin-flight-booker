FactoryBot.define do
  factory :flight do
    id
    passengers
    origin_airport { create(:origin_airport) }
    destination_airport { create(:destination_airport) }
    departure_time { Faker::Time.unique.between(from: Date.today, to: Date.today + 1 ).to_datetime }
    duration { DateTime.parse("01:02:00").to_datetime }
  end
end
