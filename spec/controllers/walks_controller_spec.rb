require "rails_helper"

RSpec.describe WalksController, type: :controller do
  let(:user) { create :user }
  let(:route) { create :route }

  describe "POST #create" do
    context "without user" do
      it "it should return 401" do
        post :create, params: { route_id: route.id }
        expect(response).to be_unauthorized
      end
    end

    context "with user" do
      before { login user }

      context "everything ok" do
        it "creates walk for the user" do
          expect(user.walks).to be_empty
          post :create, params: { route_id: route.id }
          expect(user.walks.count).to eq 1
        end

        it "returns the walk" do
          post :create, params: { route_id: route.id }
          expect(response).to be_ok
          expect(response.body).to match_schema "walks/walk"
        end
      end

      context "routes does not exist" do
        it "returns a 404" do
          post :create, params: { route_id: 1 }
          expect(response).to be_not_found
        end
      end

      context "user is already on the walk" do
        let!(:walk) { create :walk, route: route, user: user, completed_at: nil }

        it "returns a 400" do
          post :create, params: { route_id: route.id }
          expect(response).to be_bad_request
        end
      end

      context "user has already completed the route" do
        let!(:walk) { create :walk, route: route, user: user, completed_at: 1.day.ago }

        it "returns a 400" do
          post :create, params: { route_id: route.id }
          expect(response).to be_bad_request
        end
      end
    end
  end
end
