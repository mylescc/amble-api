require 'rails_helper'

RSpec.describe RoutesController, type: :controller do

  describe "GET #index" do
    let!(:route1) { create :route }
    let!(:route2) { create :route }

    it "returns all routes" do
      get :index
      expect(response).to be_ok
      parsed_body = JSON.parse(response.body).deep_symbolize_keys
      expect(parsed_body[:count]).to eq 2
      expect(parsed_body[:data][0]).to eq route1.as_json
      expect(parsed_body[:data][1]).to eq route2.as_json
    end
  end
end
