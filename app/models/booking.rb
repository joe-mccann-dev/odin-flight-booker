class Booking < ApplicationRecord
  belongs_to :flight
  
  has_many :passengers
  accepts_nested_attributes_for :passengers

  # def self.search(search)
  #   if search
  #     booking = find_by(confirmation_number: search.strip.downcase)
  #     if booking
  #       self.where(confirmation_number: booking.confirmation_number.downcase)
  #     else
  #       @bookings = Booking.all
  #     end
  #   else
  #     @bookings = Booking.all
  #   end
  # end

  def self.search(search)
    if search
      booking = joins(:passengers)
                .where(passengers: {email: search.strip.downcase } )
                .or(where(confirmation_number: search.strip.downcase))
                .includes(flight: [:origin_airport, :destination_airport])
    end
  end
end
