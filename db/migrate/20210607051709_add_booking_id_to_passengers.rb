class AddBookingIdToPassengers < ActiveRecord::Migration[6.1]
  def change
    add_column :passengers, :booking_id, :integer
    add_index  :passengers, :booking_id
  end
end
