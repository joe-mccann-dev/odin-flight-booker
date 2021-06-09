class BookingsController < ApplicationController

  def new
    @booking = Booking.new
    @confirmation_number = SecureRandom.base36(8)
    number_of_passengers = params[:tickets].to_i
    number_of_passengers.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      flash[:success] = "Booking was successfully created."
      redirect_to @booking
    else
      render :new
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private

    def booking_params
      params.require(:booking).permit(
        :flight_id,
        :tickets,
        :confirmation_number,
        passengers_attributes: [:name, :email]
      )
    end
end