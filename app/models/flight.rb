# frozen_string_literal: true

# flights that a passenger can book
class Flight < ApplicationRecord
  has_many :bookings, dependent: :destroy # there can't be a booking without a flight
  has_many :passengers, through: :bookings
  # how to identify a departing_flight's origin_airport
  # A departing_flight needs to know its origin_airport is accessed via the origin_id key
  # An origin_airport 'owns' all departing_flights and references itself as 'origin_id'
  belongs_to :origin_airport,      class_name: 'Airport',
                                   foreign_key: 'origin_id',
                                   inverse_of: :departing_flights
  # how to identify an arriving_flight's destination_airport
  # An arriving_flight needs to know its destination_airport is accessed via the destination_id key                                   
  # A destination_airport 'owns' all arriving_flights and references itself as 'destination_id'
  belongs_to :destination_airport, class_name: 'Airport',
                                   foreign_key: 'destination_id',
                                   inverse_of: :arriving_flights

  def self.options_for_select
    all.order(:departure_time).pluck(:departure_time).map(&:to_date).uniq
  end
end
