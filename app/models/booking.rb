class Booking < ApplicationRecord
  belongs_to :flight

  has_many :passengers

  accepts_nested_attributes_for :passengers
  validates :confirmation_number, presence: true,
                                  uniqueness: true

  validate :all_form_passengers_different
  validate :all_flight_passengers_are_unique

  def self.search(search)
    if search
      booking = joins(:passengers)
                .where(passengers: { email: search.strip.downcase })
                .or(where(confirmation_number: search.strip.downcase))
                .includes(:passengers, flight: %i[origin_airport destination_airport])
    end
  end

  private

  def all_form_passengers_different
    errors.add(:booking, 'passengers must have their own email.') unless current_passengers_unique_to_each_other?
  end

  def current_passengers_unique_to_each_other?
    passengers.size == passengers.uniq { |passenger| passenger.email }
                                 .size
  end

  def all_flight_passengers_are_unique
    errors.add(:passengers, 'email entered is already registered to this flight.') if flight_contains_form_passengers?
  end

  def flight_contains_form_passengers?
    passengers.any? do |passenger|
      flight.passengers.any? do |p|
        passenger.email == p.email
      end
    end
  end
end
