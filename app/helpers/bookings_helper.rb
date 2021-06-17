module BookingsHelper
  def pluralize_passengers
    pluralize(params[:tickets].to_i, 'passenger')
  end

  def bookings_searched_and_found?
    params[:search] && @bookings.any?
  end

end