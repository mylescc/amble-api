require "rails_helper"

describe UpdateStepDay do
  describe "#call" do
    let(:step_day) { create :step_day, steps: 0 }
    let(:service) { double Walks::UpdateSteps }
    let(:steps) { 89 }

    subject { described_class.new(walks_update_steps: service) }

    it "updates number of steps on the step day" do
      subject.call(step_day: step_day, steps: steps)
      expect(step_day.reload.steps).to eq steps
    end

    it "updates all walks the user is on" do
      walk1 = create :walk, user: step_day.user, started_at: 1.day.ago
      walk2 = create :walk, :completed, user: step_day.user, started_at: 1.day.ago
      expect(service).to receive(:call).with(walk: walk1)
      expect(service).to_not receive(:call).with(walk: walk2)
      subject.call(step_day: step_day, steps: steps)
    end
  end
end
