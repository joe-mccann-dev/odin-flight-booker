require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'Validations' do
    
    subject { create(:flight) }

    it 'has valid attributes' do
      expect(subject).to be_valid
    end
  end

  describe 'Associations' do
    it { should have_many(:bookings) }
    it { should have_many(:passengers).through(:bookings) }
  end
end
