class FlightsController < ApplicationController

  def index
    @airports = Airport.all.map { |airport| [ airport.code, airport.id ] }
    @all_flights = Flight.all.order(:departure_time)
    @departure_times = @all_flights
                       .map { |flight| [ flight.departure_time_formatted, flight.departure_time ] }
                       .uniq { |formatted_time, full_time| formatted_time }
    @flights_to_display_at_index = @all_flights.limit(20)
                                               .order(:departure_time)
    @flights =  if params[:origin_id].nil?
                  @flights_to_display_at_index
                else
                  date = params[:departure_time].to_datetime
                  @all_flights.where(origin_id: params[:origin_id],
                               destination_id: params[:destination_id],
                               departure_time: flights_on_selected_date(date) )
                end
    
  end

  def flights_on_selected_date(date)
    DateTime.new(date.year, date.month, date.day, 0, 0, 0)..
    DateTime.new(date.year, date.month, date.day, 23, 59, 59)
  end

  def flight_params
    params.require(:flight).permit(:origin_id, :destination_id, :departure_time)
  end
end
