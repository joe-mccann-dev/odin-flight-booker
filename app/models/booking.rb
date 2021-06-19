class Booking < ApplicationRecord
  belongs_to :flight
  
  has_many :passengers

  accepts_nested_attributes_for :passengers
  validates_uniqueness_of :confirmation_number
  
  def self.search(search)
    if search
      booking = joins(:passengers)
                .where(passengers: { email: search.strip.downcase } )
                .or(where(confirmation_number: search.strip.downcase))
                .includes(:passengers, flight: [:origin_airport, :destination_airport])
    end
  end
end
