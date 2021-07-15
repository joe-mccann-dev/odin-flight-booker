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
    31.times do |day|
      # ensure a short flight is at least 45 minutes long
      minute = distance.zero? ? (45..59).to_a.sample : (rand * 60).floor
      # create flights to each "other_airport" for each day for the next 30 days
      2.times do
        Flight.create(
                      airline: airlines.sample,
                      flight_number: Faker::Number.unique.between(from: 100, to: 100000),
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
