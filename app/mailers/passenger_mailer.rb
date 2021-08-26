class PassengerMailer < ApplicationMailer
  before_action :set_booking_and_passenger

  default from: 'joe.mccann.dev@gmail.com'

  def confirmation_email
    mail(
      to: email_address_with_name(@passenger.email, @passenger.name),
      subject: 'Booking Confirmation'
    )
  end

  private

  def set_booking_and_passenger
    @booking = params[:booking]
    @passenger = params[:passenger]
  end
end
