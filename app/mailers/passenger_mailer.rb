class PassengerMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def confirmation_email
    @booking = params[:booking]
    @passenger = params[:passenger]
    @booking_url = "http://127.0.0.1:3000/bookings/#{@booking.id}"
    mail(
      to: email_address_with_name(@passenger.email, @passenger.name),
      subject: 'Booking Confirmation'
    )
  end
end
