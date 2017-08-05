class StepsController < ApplicationController
  before_action :authenticate_user!

  def register_steps
    step_day = find_or_create_step_day
    update_step_day_service.call(
      step_day: step_day,
      steps: params[:total_steps].to_i
    )
    head :ok
  end

  private

  def date
    @date ||= Date.parse(params[:date])
  end

  def find_or_create_step_day
    current_user
      .step_days
      .where(date: date)
      &.first || StepDay.create(user: current_user, date: date)
  end

  def update_step_day_service
    @update_step_day_servicea ||= UpdateStepDay.new
  end
end
