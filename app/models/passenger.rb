class Passenger < ApplicationRecord
  has_many :bookings
  has_many :flights, through: :bookings

  validates :name, presence: true
  validates :email, presence: true

  validate :existing_passenger_email_uses_same_name

  private

  def existing_passenger_email_uses_same_name
    if Passenger.all.any? { |pass| self.email == pass.email && self.name != pass.name }
      errors.add(:email, "exists with a different name")
    end
  end


end