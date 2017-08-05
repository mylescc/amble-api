class UpdateStepDay
  attr_reader :walks_update_steps

  def initialize(walks_update_steps: Walks::UpdateSteps.new)
    @walks_update_steps = walks_update_steps
  end

  def call(step_day:, steps:)
    step_day.update(steps: steps.to_i)
    step_day.user.walks.active.each do |walk|
      walks_update_steps.call(walk: walk)
    end
  end
end
