module FlightsHelper
  def long_date_format
    params[:departure_time].to_date.strftime("%A %B %-dth, %Y")
  end

  def short_time_format(flight)
    flight.departure_time.strftime("%l:%M %p")
  end

  def duration_formatted(flight)
    duration = flight.duration.to_datetime
    hours = duration.hour
    minutes = duration.minute
    "#{hours}hr #{minutes}min"
  end

  def show_selected_airport(location_id)
    Airport.find(location_id).code
  end
end
