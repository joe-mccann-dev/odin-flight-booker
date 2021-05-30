class RemoveAirportIdsFromBookings < ActiveRecord::Migration[6.1]
  def change
    remove_columns :bookings, :origin_id, :destination_id
  end
end
