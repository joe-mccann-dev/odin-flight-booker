require "rails_helper"

RSpec.describe Airport, type: :model do
  describe "Associations" do
    it { should have_many(:departing_flights) }
    it { should have_many(:arriving_flights) }
  end
end
