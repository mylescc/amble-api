# frozen_string_literal: true

class Walk < ApplicationRecord
  COMPLETE_STATUS = 'complete'
  IN_PROGRESS_STATUS = 'in-progress'
  NOT_STARTED_STATUS = 'not-started'

  belongs_to :user
  belongs_to :route

  delegate :name, to: :route

  scope :active, -> { where(completed_at: nil) }
  scope :in_progress, -> { where(completed_at: nil).where.not(steps_complete: 0) }
  scope :not_started, -> { where(completed_at: nil, steps_complete: 0) }
  scope :completed, -> { where.not(completed_at: nil) }

  def distance_total_km
    route.distance_km
  end

  def distance_left_km
    distance_total_km - distance_complete_km
  end

  def steps_total
    route.distance_steps
  end

  def steps_left
    steps_total - steps_complete
  end

  def status
    if completed_at.present?
      COMPLETE_STATUS
    elsif steps_complete.zero? && completed_at.nil?
      NOT_STARTED_STATUS
    else
      IN_PROGRESS_STATUS
    end
  end

  def complete?
    completed_at.present?
  end
end
