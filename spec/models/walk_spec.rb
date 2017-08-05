require 'rails_helper'

RSpec.describe Walk, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:route) }
  end

  describe '#name' do
    it 'delegates to route' do
      route = create :route
      walk = create :walk, route: route
      expect(walk.name).to eq route.name
    end
  end

  describe '#distance_total_km' do
    it 'delegates to route' do
      route = create :route
      walk = create :walk, route: route
      expect(walk.distance_total_km).to eq route.distance_km
    end
  end

  describe '#steps_total' do
    it 'delegates to route' do
      route = create :route
      walk = create :walk, route: route
      expect(walk.steps_total).to eq route.distance_steps
    end
  end

  describe '#distance_left_km' do
    it 'calculates remaining km' do
      route = create :route, distance_km: 1_000
      walk = create :walk, route: route, distance_complete_km: 250
      expect(walk.distance_left_km).to eq 750
    end
  end

  describe '#steps_left' do
    it 'calculates remaining steps' do
      route = create :route, distance_steps: 1_000
      walk = create :walk, route: route, steps_complete: 250
      expect(walk.steps_left).to eq 750
    end
  end

  describe '#status' do
    context 'no progress' do
      it 'returns "not-started"' do
        walk = create :walk, steps_complete: 0, completed_at: nil
        expect(walk.status).to eq 'not-started'
      end
    end

    context 'in progress' do
      it 'returns "in-progress"' do
        walk = create :walk, steps_complete: 50, completed_at: nil
        expect(walk.status).to eq 'in-progress'
      end
    end

    context 'complete' do
      it 'returns "complete"' do
        walk = create :walk, steps_complete: 50, completed_at: 1.day.ago
        expect(walk.status).to eq 'complete'
      end
    end
  end

  describe '#complete?' do
    it 'returns true if completed_at is present' do
      walk = create :walk, completed_at: Time.zone.now
      expect(walk).to be_complete
    end

    it 'returns false if completed_at is not present' do
      walk = create :walk, completed_at: nil
      expect(walk).to_not be_complete
    end
  end
end
