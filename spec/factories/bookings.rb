FactoryBot.define do
  factory :booking do
    association :flight, factory: :flight

    id { Faker::Number.unique.number(digits: 8) }
    flight_id { flight.id }
    confirmation_number { SecureRandom.base36(8) }
    tickets { 2 }

    after(:create) do |booking|
      create_list(:passenger, 2, booking_id: booking.id)
    end

  end
end
