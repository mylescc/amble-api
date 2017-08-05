class Walk < ApplicationRecord
  COMPLETE_STATUS = "complete".freeze
  IN_PROGRESS_STATUS = "in-progress".freeze
  NOT_STARTED_STATUS = "not-started".freeze

  belongs_to :user
  belongs_to :route

  delegate :name, to: :route

  scope :active, -> { where(completed_at: nil) }

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
    elsif steps_complete == 0 && completed_at.nil?
      NOT_STARTED_STATUS
    else
      IN_PROGRESS_STATUS
    end
  end

  def complete?
    completed_at.present?
  end
end
