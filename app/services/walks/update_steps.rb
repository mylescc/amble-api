module Walks
  class UpdateSteps
    def call(walk:)
      user = walk.user
      relevant_step_days = user.step_days.since(walk.started_at)
      total_steps = relevant_step_days.sum(&:steps)
      max_distance = walk.route.distance_steps
      completed_at = nil

      if total_steps > max_distance
        total_steps = 0
        final_step_day = relevant_step_days.find do |step_day|
          total_steps += step_day.steps
          total_steps >= max_distance
        end
        completed_at = final_step_day.date
      end

      walk.update(
        steps_complete: [total_steps, max_distance].min,
        completed_at: completed_at
      )
    end
  end
end
