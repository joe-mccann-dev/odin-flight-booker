require "rails_helper"

RSpec.describe Booking, type: :model do
  describe "Validations" do
    subject { create(:booking) }

    it "has valid attributes" do
      expect(subject).to be_valid
    end

    it "fails validation without a confirmation number" do
      booking = build(:booking, confirmation_number: nil)
      expect(booking).to_not be_valid
    end

    context "a flight has a passenger booked" do
      # established flight that already has passengers booked
      let(:flight) { create(:flight_with_bookings) }
      # build a new booking object, associate flight with above flight
      let(:booking) { build(:booking, flight: flight) }

      context "a user tries to book a flight that already contains an entered email address" do
        it "fails validation" do
          # build a passenger and have their info be the same as flight.passengers.first's info
          passenger_with_same_info = build(:passenger, name: flight.passengers.first.name, email: flight.passengers.first.email)
          # add that passenger to built booking
          booking.passengers << passenger_with_same_info
          # expect that booking to not be valid because passenger email is already registered to flight (booking.rb line 35)
          expect(booking).to_not be_valid
        end
      end
    end

    context "a booking passengers form contains duplicate emails" do
      let(:passenger1) { build(:passenger, email: "one@example.com") }
      let(:passenger2) { build(:passenger, email: passenger1.email) }
      let(:booking) { build(:booking, passengers: [passenger1, passenger2]) }
      it "fails validation" do
        expect(booking).to_not be_valid
      end
    end
  end

  describe "Associations" do
    it { should have_many(:passengers) }
  end
end
