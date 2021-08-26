require "rails_helper"

RSpec.describe PassengerMailer, type: :mailer do
  describe "confirmation_email" do
    let(:booking) { create(:booking) }
    let(:passenger) { create(:passenger) }
    let(:mail) { PassengerMailer.with(booking: booking, passenger: passenger).confirmation_email }
    let(:url) { "http://localhost:3000/bookings/#{booking.id}" }

    it "renders the headers" do
      expect(mail.subject).to eq("Booking Confirmation")
      expect(mail.to).to eq([passenger.email])
      expect(mail.from).to eq(["joe.mccann.dev@gmail.com"])
    end

    it "includes a url to the booking page" do
      expect(mail.body.encoded).to include(url)
    end
  end
end
