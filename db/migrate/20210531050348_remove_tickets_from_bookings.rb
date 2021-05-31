class RemoveTicketsFromBookings < ActiveRecord::Migration[6.1]
  def change
    remove_column(:bookings, :tickets) 
  end
end
