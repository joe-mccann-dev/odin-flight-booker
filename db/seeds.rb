# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

airports = []

abbreviations = %w[
  BOS
  JFK
  ORD
  ATL
  DFW
  SFO
  SEA
]

abbreviations.each do |abbreviation|
  airport = Airport.new(code: abbreviation)
  airport.save
  airports << airport
end

airports.each do |airport|

  other_airports = airports.reject { |a| a == airport }

  other_airports.each_with_index do |other_airport, distance|
    30.times do |day|
      second = (rand * 60).floor
      minute = (rand * 60).floor
      # create between 2 flights to each "other_airport" for each day for the next 30 days
      2.times do
        Flight.create(origin_id: airport.id, 
                      destination_id: other_airport.id, 
                      duration: DateTime.parse("#{distance}:#{minute}:#{second}").to_datetime,
                      departure_time: Faker::Time.unique.between(from: Date.today + day, to: Date.today + (day + 1) , format: :default).to_datetime
                    )
      end
    end
  end

end
