# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

airports = []

abbreviations = {
  "BOS": "Boston, MA",
  "JFK": "New York, NY",
  "ORD": "Chicago, IL",
  "ATL": "Atlanta, GA",
  "DFW": "Dallas, TX",
  "SFO": "San Francisco, CA",
  "SEA": "Seattle, WA"
}

airlines = %w[
  Delta
  Jet-Blue
  Southwest
  American
  United
  Alaska
]

abbreviations.each do |abbreviation, location|
  airport = Airport.new(code: abbreviation, location: location)
  airport.save
  airports << airport
end

airports.each do |airport|

  other_airports = airports.reject { |a| a == airport }

  other_airports.each_with_index do |other_airport, distance|
    30.times do |day|
      minute = distance.zero? ? (45..59).to_a.sample : (rand * 60).floor
      # create between 2 flights to each "other_airport" for each day for the next 30 days
      2.times do
        Flight.create(
                      airline: airlines.sample,
                      flight_number: Faker::Number.unique.between(from: 100, to: 10000),
                      origin_id: airport.id, 
                      destination_id: other_airport.id, 
                      duration: DateTime.parse("#{distance}:#{minute}:00").to_datetime,
                      departure_time: Faker::Time.unique.between(from: Date.today + day, 
                                                                 to: Date.today + (day + 1),
                                                                 format: :default)
                                                                 .to_datetime
                    )
      end
    end
  end

end
