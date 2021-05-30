class AddTicketsToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :tickets, :integer
  end
end
