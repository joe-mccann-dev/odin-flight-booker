class BookingsController < ApplicationController

  def new
    if params[:tickets].present?
      unless flash[:error]
        flash[:info] = "Your booking is almost complete. Please fill out passenger info below."
      end
      @booking = Booking.new
      set_number_of_passengers(@booking)
      @flight = Flight.find(params[:flight_id])
    else
      flash[:warning] = "Please select number of passengers before booking a flight."
      redirect_to root_path
    end
  end

  def create
    @booking = Booking.new(booking_params)
    set_confirmation_number(@booking)
    if @booking.save
      flash[:success] = "Success! Your Booking is complete. 
      #{@booking.flight.airline} will email you with boarding details."
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
        passengers_attributes: [:name, :email]
      )
    end

    def set_number_of_passengers(booking)
      @number_of_passengers = params[:tickets].to_i
      @number_of_passengers.times { booking.passengers.build }
    end

    def set_confirmation_number(booking)
      begin
        confirmation_number = SecureRandom.base36(8)
      end while Booking.exists?(confirmation_number: confirmation_number)
  
      booking.confirmation_number = confirmation_number
    end
end