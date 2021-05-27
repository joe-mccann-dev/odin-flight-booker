class Flight < ApplicationRecord
  belongs_to :origin_airport,      class_name: 'Airport', foreign_key: 'origin_id'
  belongs_to :destination_airport, class_name: 'Airport', foreign_key: 'destination_id'

  scope :current_flights, -> { where("departure_time > ?", Time.zone.today) }

  def departure_time_formatted
    departure_time.strftime("%m/%d/%Y")
  end

end
