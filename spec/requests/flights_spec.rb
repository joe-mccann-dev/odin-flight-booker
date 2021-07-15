require 'rails_helper'

RSpec.describe "Flights", type: :request do
  describe "GET flights#index" do
    it "should get the index path" do
      get flights_path
      expect(response).to have_http_status(200)
    end
  end
end
