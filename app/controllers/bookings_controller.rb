class BookingsController < ApplicationController

  def new
    flash[:info] = "Your booking is almost complete. Please fill out passenger info below."
    @booking = Booking.new
    @flight = Flight.find(params[:flight_id])
    number_of_passengers = params[:tickets].to_i
    number_of_passengers.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.confirmation_number = SecureRandom.base36(8)
    if @booking.save
      flash[:success] = "Success! Your Booking is complete. 
      #{@booking.flight.airline} will contact you with boarding details."
      redirect_to @booking
    else
      render :new
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