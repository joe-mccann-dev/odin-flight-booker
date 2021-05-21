class CreateFlights < ActiveRecord::Migration[6.1]
  def change
    create_table :flights do |t|
      t.integer :origin_id
      t.integer :destination_id
      t.datetime :departure_time
      t.datetime :duration

      t.timestamps
    end
  end
end
