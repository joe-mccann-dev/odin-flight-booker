# frozen_string_literal: true

# Primarily contains formatting helpers for view
module FlightsHelper
  def long_date_format
    params[:departure_time].to_date.strftime('%A %B %-d, %Y')
  end

  def short_time_format(flight)
    flight.departure_time.strftime('%l:%M %p')
  end

  def short_date_format(flight)
    flight.departure_time.to_date.strftime('%Y-%m-%d')
  end

  def duration_formatted(flight)
    duration = flight.duration.to_datetime
    hours = duration.hour
    minutes = duration.minute
    "#{hours}hr #{minutes}min"
  end

  def show_selected_airport(location_id)
    Airport.find(location_id).location
  end

  def params_present_and_no_flights_found?
    required = %i[origin_id destination_id departure_time tickets]
    required.any? { |key| params.key?(key) } &&
      @available_flights.empty?
  end
end
