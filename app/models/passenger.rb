class Passenger < ApplicationRecord
  validates :name, presence: true, length: { in: 3..50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                                    format: { with: VALID_EMAIL_REGEX }
  
  validate :existing_passenger_email_uses_same_name

  private

  def existing_passenger_email_uses_same_name
    if Passenger.all.any? { |pass| self.email == pass.email && self.name != pass.name }
      errors.add(:email, "exists with a different name")
    end
  end


end