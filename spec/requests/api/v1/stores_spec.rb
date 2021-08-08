require 'rails_helper'

RSpec.describe "Stores", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/stores/new"
      expect(response).to have_http_status(:success)
    end
  end

end
