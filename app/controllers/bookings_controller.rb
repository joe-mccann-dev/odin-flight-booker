# frozen_string_literal: true

# Controls the creation of Bookings. Allows search functionality
class BookingsController < ApplicationController
  def new
    if params[:tickets].present?
      flash.now[:info] = 'Your booking is almost complete. Please fill out passenger info below.'
      @booking = Booking.new
      build_booking_passengers(@booking)
      @flight = Flight.find(params[:flight_id])
    else
      flash[:warning] = 'Please select number of passengers before booking a flight.'
      redirect_to root_path
    end
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      send_confirmation_emails(@booking)
      flash[:success] = "Successfully booked #{@booking.flight.airline} flight ##{@booking.flight.flight_number}! A confirmation has been emailed to each passenger."
      redirect_to @booking
    else
      flash[:error] = @booking.errors.full_messages.to_sentence
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @flight = @booking.flight
  end

  def index
    @bookings = Booking.search(params[:search])
  end

  private

  def booking_params
    params.require(:booking).permit(
      :flight_id,
      :tickets,
      :search,
      :confirmation_number,
      passengers_attributes: %i[name email]
    )
  end

  def build_booking_passengers(booking)
    @number_of_passengers = params[:tickets].to_i
    @number_of_passengers.times { booking.passengers.build }
  end

  def send_confirmation_emails(booking)
    booking.passengers.each do |passenger|
      # #with sends params to PassengerMailer
      PassengerMailer.with(booking: booking,
                           passenger: passenger)
                     .confirmation_email
                     .deliver_later
    end
  end
end
