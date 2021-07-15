require "rails_helper"

RSpec.describe "Bookings", type: :system do
  before do
    driven_by(:rack_test)
    Rails.application.load_seed
  end

  describe "Booking a Flight" do
    subject(:passenger_0) { build(:passenger) }
    subject(:passenger_1) { build(:passenger) }

    context "a user has selected a flight and now wishes to book the flight" do

      # select flight parameters and click 'find flights'
      before(:each) do
        visit "/"

        # select parameters
        select("Boston, MA", from: "origin_id")
        select("New York, NY", from: "destination_id")
        select("2021-07-20", from: "departure_time")
        select("2", from: "tickets")

        # get results
        click_on "Find Flights"
      end

      it "allows them to enter passenger information and book the flight", js: true do
        # find first available flight through hidden input in form
        flight_id = find("input[name='flight_id']", match: :first, visible: false).value
        # find button associated with flight_id and click on it
        find("input[data-test-id='#{flight_id}']").click
        expect(page).to have_content("Your booking is almost complete")

        fill_in("booking_passengers_attributes_0_name", with: passenger_0.name)
        fill_in("booking_passengers_attributes_0_email", with: passenger_0.email)
        fill_in("booking_passengers_attributes_1_name", with: passenger_1.name)
        fill_in("booking_passengers_attributes_1_email", with: passenger_1.email)

        expect(page).to have_button("Complete Booking")

        click_on "Complete Booking"

        expect(page).to have_current_path(booking_path("#{Booking.last.id}"))
        expect(page).to have_content("Success! Your Booking is complete.")
      end

      it "redirects back if passengers use the same email" do
        # find first available flight through hidden input in form
        flight_id = find("input[name='flight_id']", match: :first, visible: false).value
        # find button associated with flight_id and click on it
        find("input[data-test-id='#{flight_id}']").click
        expect(page).to have_content("Your booking is almost complete")

        fill_in("booking_passengers_attributes_0_name", with: passenger_0.name)
        fill_in("booking_passengers_attributes_0_email", with: passenger_0.email)
        fill_in("booking_passengers_attributes_1_name", with: passenger_1.name)
        # same email as passenger_0
        fill_in("booking_passengers_attributes_1_email", with: passenger_0.email)

        expect(page).to have_button("Complete Booking")

        click_on "Complete Booking"

        expect(page).to have_current_path("/bookings/new?flight_id=#{flight_id}&tickets=2")
        expect(page).to have_content("passengers must have their own email.")
      end

      it "redirects back if an email entered has already been registered with a different name" do
        # find first available flight through hidden input in form
        flight_id = find("input[name='flight_id']", match: :first, visible: false).value
        # find button associated with flight_id and click on it
        find("input[data-test-id='#{flight_id}']").click
        expect(page).to have_content("Your booking is almost complete")

        passenger_with_registered_email = create(:passenger)

        # first passenger is normal and will not raise an error
        fill_in("booking_passengers_attributes_0_name", with: passenger_0.name)
        fill_in("booking_passengers_attributes_0_email", with: passenger_0.email)
        # second passenger tries to book with their own unique name
        # but tries to use same email as 'passenger_with_registered_email'
        fill_in("booking_passengers_attributes_1_name", with: passenger_1.name)
        fill_in("booking_passengers_attributes_1_email", with: passenger_with_registered_email.email)

        expect(page).to have_button("Complete Booking")

        click_on "Complete Booking"

        expect(page).to have_content("Passengers email exists with a different name")
      end

      it "redirects back if a passenger email entered is already booked to desired flight" do
        # find first available flight through hidden input in form
        flight_id = find("input[name='flight_id']", match: :first, visible: false).value
        # find button associated with flight_id and click on it
        find("input[data-test-id='#{flight_id}']").click
        expect(page).to have_content("Your booking is almost complete")

        fill_in("booking_passengers_attributes_0_name", with: passenger_0.name)
        fill_in("booking_passengers_attributes_0_email", with: passenger_0.email)
        fill_in("booking_passengers_attributes_1_name", with: passenger_1.name)
        fill_in("booking_passengers_attributes_1_email", with: passenger_1.email)

        expect(page).to have_button("Complete Booking")

        click_on "Complete Booking"

        expect(page).to have_current_path(booking_path("#{Booking.last.id}"))
        expect(page).to have_content("Success! Your Booking is complete.")

        ####-----------now try to book same flight with an email from above-------------####

        visit "/"

        # select parameters
        select("Boston, MA", from: "origin_id")
        select("New York, NY", from: "destination_id")
        select("2021-07-20", from: "departure_time")
        select("2", from: "tickets")

        # get results
        click_on "Find Flights"

        # # find button associated with flight_id and click on it
        find("input[data-test-id='#{flight_id}']").click
        expect(page).to have_content("Your booking is almost complete")

        fill_in("booking_passengers_attributes_0_name", with: passenger_0.name)
        fill_in("booking_passengers_attributes_0_email", with: passenger_0.email)
        fill_in("booking_passengers_attributes_1_name", with: passenger_1.name)
        fill_in("booking_passengers_attributes_1_email", with: passenger_1.email)

        expect(page).to have_button("Complete Booking")

        click_on "Complete Booking"

        expect(page).to have_content("email entered is already registered to this flight.")
        expect(page).to have_current_path("/bookings/new?flight_id=#{flight_id}&tickets=2")
      end
    end

    context "a user searches for flights without selecting number of passengers" do
      before do
        visit "/"

        # select parameters
        select("Boston, MA", from: "origin_id")
        select("New York, NY", from: "destination_id")
        select("2021-07-20", from: "departure_time")
        # note absence of tickets param

        # get results
        click_on "Find Flights"
      end

      it "redirects to root path" do
        # find first available flight through hidden input in form
        flight_id = find("input[name='flight_id']", match: :first, visible: false).value
        # find button associated with flight_id and click on it
        find("input[data-test-id='#{flight_id}']").click
        expect(page).to have_current_path(root_path)
        expect(page).to have_content("Please select number of passengers before booking a flight.")
      end
    end
  end

  describe "Searching for a Booking" do
    
    subject(:booking) { create(:booking, passengers: [ create(:passenger)]) }
    subject(:passenger) { booking.passengers.first }

    context "a passenger wants to look up their booking by confirmation number" do

      before(:each) do
        visit '/bookings'
        fill_in "search", with: booking.confirmation_number
        click_on "Search"
      end

      it "shows the passenger a link to that specific booking" do
        expect(page).to have_current_path("/bookings?search=#{booking.confirmation_number}")
        expect(page).to have_content(booking.confirmation_number)
      end

      it "shows them the booking page when they click on a link" do
        click_on "#{booking.confirmation_number}"
        expect(page).to have_current_path(booking_path(booking))
        expect(page).to have_content(booking.flight.flight_number)
        expect(page).to have_content(passenger.name)
        expect(page).to have_content(passenger.email)
      end
    end

    context "a passenger wants to look up their bookings by their email address" do
      
      before(:each) do
        visit '/bookings'
        fill_in "search", with: passenger.email
        click_on "Search"
      end

      it "shows the passenger a link their booking" do
        expect(page).to have_current_path("/bookings?search=#{passenger.email}")
        expect(page).to have_content(booking.confirmation_number)
      end
    end
  end
end
