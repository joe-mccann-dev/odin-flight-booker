class Booking < ApplicationRecord
  belongs_to :flight
  
  has_many :passengers

  accepts_nested_attributes_for :passengers
  validates :confirmation_number, presence: true,
                                  uniqueness: true
  
  validate :all_form_passengers_different
  
  def self.search(search)
    if search
      booking = joins(:passengers)
                .where(passengers: { email: search.strip.downcase } )
                .or(where(confirmation_number: search.strip.downcase))
                .includes(:passengers, flight: [:origin_airport, :destination_airport])
    end
  end

  private

    def all_form_passengers_different
      unless current_passengers_unique_to_each_other?
        errors.add(:booking, "passengers must have their own email.")
      end
    end

    def current_passengers_unique_to_each_other?
      self.passengers.size == self.passengers.uniq { |passenger| passenger.email }
                                             .size
    end

end
