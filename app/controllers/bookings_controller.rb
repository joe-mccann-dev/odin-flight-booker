class BookingsController < ApplicationController

  # Set up your #new action, which should have received the flight ID and passenger number parameters, 
  # and use it to help render a form for a new booking which displays the currently chosen date, airports, 
  # flight ID and a set of fields to enter personal information for each passenger. 
  # You’ll want to create a new blank Passenger object in your controller for each passenger, 
  # and then use #fields_for in the view to set up the sub-forms.

  def new
    @flight = Flight.find(params[:flight_id])
    @number_of_passengers = params[:tickets]
    @number_of_passengers.times do
      # Passenger.new
    end
  end

  def create
  end
end