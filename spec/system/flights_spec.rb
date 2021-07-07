require 'rails_helper'

RSpec.describe "Flights", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'Searching for a flight' do
    context 'a user is selecting search parameters to find a flight they wish to book' do
      it 'allows them to select parameters and view available flights', js: true do
       
        # visit home page
        visit '/flights'

        # find('#origin_id').find(:xpath, 'option[1]').select_option
        # find('#destination_id').find(:xpath, 'option[1]').select_option
        save_and_open_page
        select("Boston, MA", from: 'origin_id', visible: false)
        

        # click_on 'Find Flights'
        # expect(page).to have_content('Book Flight')
      end
    end
  end
end
