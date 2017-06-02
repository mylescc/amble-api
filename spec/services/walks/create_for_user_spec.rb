require "rails_helper"

RSpec.describe Walks::CreateForUser, type: :service do
  let(:user) { create :user }
  let(:route) { create :route }

  describe "#call" do
    context "all ok" do
      it "creates the walk with user and route attached" do
        walk = subject.call(user: user, route_id: route.id)
        expect(walk.user).to eq user
        expect(walk.route).to eq route
      end
    end

    context "no route" do
      it "raises an error" do
        expect do
          subject.call(user: user, route_id: 1)
        end.to raise_error Walks::Error::RouteNotFound
      end
    end

    context "route already in progress" do
      let!(:walk) { create :walk, user: user, route: route }

      it "raises an error" do
        expect do
          subject.call(user: user, route_id: route.id)
        end.to raise_error Walks::Error::RouteAlreadyInProgress
      end
    end

    context "route already completed" do
      let!(:walk) { create :walk, user: user, route: route, completed_at: Time.zone.now }
      it "raises an error" do
        expect do
          subject.call(user: user, route_id: route.id)
        end.to raise_error Walks::Error::RouteAlreadyCompleted
      end
    end
  end
end
