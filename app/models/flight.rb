class Flight < ApplicationRecord
  has_many :bookings
  has_many :passengers, through: :bookings
  belongs_to :origin_airport,      class_name: 'Airport', foreign_key: 'origin_id'
  belongs_to :destination_airport, class_name: 'Airport', foreign_key: 'destination_id'

  def self.options_for_select
    all.order(:departure_time).pluck(:departure_time).map(&:to_date).uniq
  end
end
