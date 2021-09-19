# frozen_string_literal: true

# limited number of airports. Can be selected at '/flights'
class Airport < ApplicationRecord
  # how to identify an origin_airport's departing_flights
  # will look for column flights.airport_id unless foreign_key is specified...
  # EXAMPLE Airport.last.departing_flights.last.origin_airport will not work, because 
  # ActiveRecord will try to find flights.airport_id which there is no column for and is not specific enough--
  # the origin_airport is necessary information for this use case.
  # ActiveRecord needs to know each departing_flight contains a reference to its origin_airport (the foreign_key: origin_id)
  has_many :departing_flights, class_name: 'Flight',
                               foreign_key: 'origin_id',
                               inverse_of: :origin_airport

  has_many :arriving_flights,  class_name: 'Flight',
                               foreign_key: 'destination_id',
                               inverse_of: :destination_airport

  def self.options_for_select
    all.pluck(:location, :id)
  end
end
