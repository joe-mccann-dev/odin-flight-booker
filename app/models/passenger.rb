class Passenger < ApplicationRecord
  
  validates :name, presence: true, length: { in: 3..50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                                    format: { with: VALID_EMAIL_REGEX }
  
  validate :existing_passenger_email_used_same_name

  private

    def existing_passenger_email_used_same_name
      if passenger_used_email_with_different_name?
        errors.add(:email, "exists with a different name")
      end
    end

    def passenger_used_email_with_different_name?
      Passenger.all.any? do |passenger|
        self.email == passenger.email && self.name != passenger.name
      end
    end
end