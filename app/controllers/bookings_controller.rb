class BookingsController < ApplicationController

  def new
    @booking = Booking.new
    number_of_passengers = params[:tickets].to_i
    number_of_passengers.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to root_url, notice: "Booking was successfully created."
    else
      render :new
    end
  end

  private

    def booking_params
      params.require(:booking).permit(
        :flight_id,
        :tickets,
        passengers_attributes: [:name, :email]
      )
    end
end