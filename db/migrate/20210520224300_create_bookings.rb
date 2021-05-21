class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.integer :flight_id
      t.integer :passenger_id
      t.integer :origin_id
      t.integer :destination_id

      t.timestamps
    end
  end
end
