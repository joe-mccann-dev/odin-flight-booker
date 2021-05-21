class Flight < ApplicationRecord
  belongs_to :origin_airport,      class_name: 'Airport', foreign_key: 'origin_id'
  belongs_to :destination_airport, class_name: 'Airport', foreign_key: 'destination_id'
end
