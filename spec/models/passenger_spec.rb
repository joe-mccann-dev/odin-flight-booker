require 'rails_helper'

RSpec.describe Passenger, type: :model do
  describe 'Validations' do
    
    subject { create(:passenger) }

    it 'has valid attributes' do
      expect(subject).to be_valid
    end

    it 'fails validation without an email' do
      passenger = build(:passenger, email: nil)
      expect(passenger).to_not be_valid
    end

    it 'fails validation without a name' do
      passenger = build(:passenger, name: nil)
      expect(passenger).to_not be_valid
    end

    it 'fails validation with too short a name' do
      passenger = build(:passenger, name: 'Jo')
      expect(passenger).to_not be_valid
    end

    it 'fails validation with too long a name' do
      passenger = build(:passenger, name: 'J' * 51)
      expect(passenger).to_not be_valid
    end

    it 'fails validation with too long an email' do
      passenger = build(:passenger, email: 's' * 255 + "@example.com")
      expect(passenger).to_not be_valid
    end

    it 'fails validation with an invalid email' do
      passenger = build(:passenger, email: 'john@smith.')
      expect(passenger).to_not be_valid
    end

    it 'fails validation if a passenger with a different name tries to use an existing email' do
      passenger_with_different_name_same_email = build(:passenger, name: 'Different Name', email: subject.email )
      expect(passenger_with_different_name_same_email).to_not be_valid
    end
  end
end
