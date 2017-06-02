require "rails_helper"

describe StepsController, type: :controller do
  let(:user) { create :user }

  describe "POST #register_steps" do
    context "no user" do
      it "it should return 401" do
        post :register_steps
        expect(response).to be_unauthorized
      end
    end

    context "with a user" do
      let(:params) do
        {
          "date": "25-5-2017",
          "total_steps": 80_085
        }
      end

      before { login user }

      context "user with no step day for date provided" do
        before do
          expect(user.step_days).to be_empty
        end

        it "creates new StepDay and adds step data" do
          post :register_steps, params: params
          expect(user.step_days).not_to be_empty
          step_day = user.step_days.first
          expect(step_day.date).to eq Date.new(2017, 5, 25)
          expect(step_day.steps).to eq 80_085
        end

        it "returns ok" do
          post :register_steps, params: params
          expect(response).to be_ok
        end
      end

      context "user with step data for date provided" do
        let!(:step_day) { create :step_day, user: user, date: Date.new(2017, 5, 25), steps: 1 }

        it "updates the step day count for previous StepDay" do
          post :register_steps, params: params
          expect(user.step_days.count).to eq 1
          step_day.reload
          expect(step_day.date).to eq Date.new(2017, 5, 25)
          expect(step_day.steps).to eq 80_085
        end

        it "returns ok" do
          post :register_steps, params: params
          expect(response).to be_ok
        end
      end
    end
  end
end
