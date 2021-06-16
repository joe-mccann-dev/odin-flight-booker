class AddEmailIndexToPassengers < ActiveRecord::Migration[6.1]
  def change
    add_index :passengers, :email
  end
end