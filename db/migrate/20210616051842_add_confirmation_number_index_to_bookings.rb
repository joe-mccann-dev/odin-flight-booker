class AddConfirmationNumberIndexToBookings < ActiveRecord::Migration[6.1]
  def change
    add_index :bookings, :confirmation_number, unique: true
  end
end
