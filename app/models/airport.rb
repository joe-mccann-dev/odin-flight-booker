class Airport < ApplicationRecord
  has_many :departing_flights, class_name: 'Flight', foreign_key: 'origin_id'
  has_many :arriving_flights,  class_name: 'Flight', foreign_key: 'destination_id'

  def self.options_for_select
    # all.map { |airport| [ airport.code, airport.id ] }
    all.pluck(:code, :id)
  end
end
