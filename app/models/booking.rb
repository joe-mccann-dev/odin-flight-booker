class Booking < ApplicationRecord
  belongs_to :flight
  belongs_to :airport
  belongs_to :passenger
end
