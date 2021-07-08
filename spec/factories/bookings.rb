FactoryBot.define do
  factory :booking do
    flight
    flight_id { flight.id }
    origin_id { 1 }
    destination_id { 2 }
  end
end
