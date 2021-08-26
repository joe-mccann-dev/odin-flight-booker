require "rails_helper"

RSpec.describe PassengerMailer, type: :mailer do
  describe "confirmation_email" do
    let(:booking) { create(:booking) }
    let(:passenger) { create(:passenger) }
    let(:mail) { PassengerMailer.with(booking: booking, passenger: passenger).confirmation_email }

    it "renders the headers" do
      expect(mail.subject).to eq("Booking Confirmation")
      expect(mail.to).to eq([passenger.email])
      expect(mail.from).to eq(["joe.mccann.dev@gmail.com"])
    end
  end
end
