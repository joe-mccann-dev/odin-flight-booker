require 'rails_helper'

RSpec.describe "Flights", type: :system do
  before do
    driven_by(:rack_test)
    Rails.application.load_seed
  end

  describe 'Searching for a flight' do
    context 'a user is selecting search parameters to find a flight they wish to book' do
      it 'allows them to select parameters and view available flights', js: true do
       
        # visit home page
        visit '/'

        # select parameters
        select('Boston, MA', from: 'origin_id')
        select('New York, NY', from: 'destination_id')
        select('2021-07-08', from: 'departure_time')
        select('2', from: 'tickets')
        
        # get results
        click_on 'Find Flights'
        # option to to booking page
        expect(page).to have_button('Book Flight')

      end
    end
  end
end
