require "rails_helper"

describe Walks::UpdateSteps do
  let(:user) { create :user }
  let(:route) { create :route, distance_steps: 100 }
  let(:walk) { create :walk, user: user, route: route, started_at: 1.month.ago, steps_complete: 0 }

  before do
    2.times { |index| create :step_day, user: user, steps: 20, date: index.days.ago }
    # make sure not picking up step days for other users
    create :step_day, steps: 10000, date: Date.today
  end

  describe "#call" do
    it "sums up the total number of steps from all step days from the user" do
      subject.call(walk: walk)
      expect(walk.reload.steps_complete).to eq 40
    end

    context "with step days before start of walk" do
      it "ignores step days from before walk was created" do
        create :step_day, user: user, date: (walk.started_at - 1.day), steps: 1000
        subject.call(walk: walk)
        expect(walk.steps_complete).to eq 40
      end
    end

    context "with more steps than needed" do
      it "doesn't go over the the max steps for the route" do
        create :step_day, user: user, date: (walk.started_at + 1.day), steps: 100
        subject.call(walk: walk)
        expect(walk.steps_complete).to eq route.distance_steps
      end

      it "sets the completed at to be the last step day that put it over the end" do
        day_one_date = walk.started_at + 1.day
        day_two_date = walk.started_at + 2.day
        day_one = create :step_day, user: user, date: day_one_date, steps: 90
        day_two = create :step_day, user: user, date: day_two_date, steps: 90
        subject.call(walk: walk)
        expect(walk.completed_at).to eq day_two_date.beginning_of_day
      end
    end
  end
end
