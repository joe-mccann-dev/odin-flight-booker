# frozen_string_literal: true

# Helpers for booking views
module BookingsHelper
  def pluralize_passengers
    pluralize(params[:tickets].to_i, 'passenger')
  end

  def bookings_searched_and_found?
    params[:search] && @results.any?
  end

  def generate_confirmation_number
    begin
      confirmation_number = SecureRandom.base36(8)
    end while Booking.exists?(confirmation_number: confirmation_number)

    confirmation_number
  end
end
