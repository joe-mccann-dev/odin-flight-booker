FactoryBot.define do
  factory :flight do
    id { Faker::Number.unique.number(digits: 8) }
    origin_id { create(:origin_airport).id }
    destination_id { create(:destination_airport).id }
    departure_time { Faker::Time.unique.between(from: Date.today, to: Date.today + 1).to_datetime }
    duration { DateTime.parse("01:02:00").to_datetime }
    flight_number { Faker::Number.unique.number(digits: 8) }
    airline { ["Delta", "Alaska", "Jet-Blue"].sample }

    factory :flight_with_bookings, parent: :flight do |booking|
      bookings { create_list :booking, 2 }
    end
  end
end
