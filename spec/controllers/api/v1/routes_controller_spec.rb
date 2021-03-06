require 'rails_helper'

RSpec.describe Api::V1::RoutesController, type: :controller do
  describe 'GET #index' do
    let!(:route1) { create :route }
    let!(:route2) { create :route }

    it 'returns all routes' do
      get :index
      expect(response).to be_ok
      parsed_body = JSON.parse(response.body).deep_symbolize_keys
      expect(parsed_body[:count]).to eq 2
      expect(parsed_body[:data][0][:name]).to eq route1.name
      expect(parsed_body[:data][1][:name]).to eq route2.name
    end
  end
end
