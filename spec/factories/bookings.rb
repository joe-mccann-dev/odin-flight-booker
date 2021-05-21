FactoryBot.define do
  factory :booking do
    flight_id { 1 }
    passenger_id { 1 }
    origin_id { "" }
    destination_id { 1 }
  end
end
