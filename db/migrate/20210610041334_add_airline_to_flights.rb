class AddAirlineToFlights < ActiveRecord::Migration[6.1]
  def change
    add_column :flights, :airline, :string
  end
end
