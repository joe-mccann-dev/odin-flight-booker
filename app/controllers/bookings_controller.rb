class BookingsController < ApplicationController

  def new
    if params[:tickets].present?
      @booking = Booking.new
      @flight = Flight.find(params[:flight_id])
      @number_of_passengers = params[:tickets].to_i
      @number_of_passengers.times { @booking.passengers.build }
    else
      flash[:warning] = "Please select number of passengers before booking a flight."
      redirect_to root_path
    end
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.confirmation_number = SecureRandom.base36(8)
    if @booking.save
      flash[:success] = "Success! Your Booking is complete. 
      #{@booking.flight.airline} will email you with boarding details."
      redirect_to @booking
    else
      flash[:danger] = "Failed to book flight without passenger information."
      redirect_to new_booking_path(@booking, 
                                   tickets: booking_params[:tickets],
                                   flight_id: booking_params[:flight_id])
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
        passengers_attributes: [:name, :email]
      )
    end
end