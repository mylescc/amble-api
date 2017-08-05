require 'rails_helper'

describe Api::V1::StepsController, type: :controller do
  let(:user) { create :user }
  let(:date) { 1.day.ago }

  describe 'POST #register_steps' do
    context 'no user' do
      it 'it should return 401' do
        post :register_steps
        expect(response).to be_unauthorized
      end
    end

    context 'with a user' do
      let(:params) do
        {
          'date': date.strftime('%e-%-m-%Y'),
          'total_steps': 80_085
        }
      end

      before { login user }

      context 'user with no step day for date provided' do
        before do
          expect(user.step_days).to be_empty
        end

        it 'creates new StepDay and adds step data' do
          post :register_steps, params: params
          expect(user.step_days).not_to be_empty
          step_day = user.step_days.first
          expect(step_day.date).to eq date.to_date
          expect(step_day.steps).to eq 80_085
        end

        it 'returns ok' do
          post :register_steps, params: params
          expect(response).to be_ok
        end
      end

      context 'user with step data for date provided' do
        let!(:step_day) { create :step_day, user: user, date: date, steps: 1 }

        it 'updates the step day count for previous StepDay' do
          post :register_steps, params: params
          expect(user.step_days.count).to eq 1
          step_day.reload
          expect(step_day.date).to eq date.to_date
          expect(step_day.steps).to eq 80_085
        end

        it 'returns ok' do
          post :register_steps, params: params
          expect(response).to be_ok
        end
      end

      context 'with active walk' do
        let(:route) { create :route, distance_steps: 100_000 }
        let!(:walk) { create :walk, user: user, route: route, started_at: 1.month.ago }
        let!(:walk2) { create :walk, user: user, route: route, started_at: Time.zone.today }

        it 'updates the steps on relevant walks' do
          post :register_steps, params: params
          expect(walk.reload.steps_complete).to eq 80_085
          expect(walk2.reload.steps_complete).to eq 0
        end
      end
    end
  end
end
