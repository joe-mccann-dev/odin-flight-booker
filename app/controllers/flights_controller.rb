class FlightsController < ApplicationController

  def index
    @available_flights = find_available_flights
  end

  def flights
    Flight.all.order(:departure_time)
              .includes([:origin_airport, :destination_airport])
  end

  def find_available_flights
    return flights.limit(20) unless params[:origin_id].present?
    
    date = params[:departure_time].to_datetime
    flights.where(origin_id: params[:origin_id],
                  destination_id: params[:destination_id],
                  departure_time: within_selected_date(date) )
  end

  def within_selected_date(date)
    DateTime.new(date.year, date.month, date.day).all_day
  end
end
