require 'rails_helper'

RSpec.describe "Airports", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/airports/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/airports/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/airports/show"
      expect(response).to have_http_status(:success)
    end
  end

end
