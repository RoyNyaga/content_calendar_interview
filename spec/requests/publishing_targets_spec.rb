require 'rails_helper'

RSpec.describe "PublishingTargets", type: :request do
  describe "GET /edit" do
    it "returns http success" do
      get "/publishing_targets/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
