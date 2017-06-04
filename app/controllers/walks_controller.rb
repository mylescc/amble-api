class WalksController < ApplicationController
  before_action :authenticate_user!

  def create
    walk = Walks::CreateForUser.new.call(
      user: current_user,
      route_id: params[:route_id].to_i
    )
    render json: {
      data: Walks::SingleSerializer.new(walk)
    }
  rescue Walks::Error::RouteNotFound
    head :not_found
  rescue Walks::Error::RouteAlreadyInProgress
    head :bad_request
  rescue Walks::Error::RouteAlreadyCompleted
    head :bad_request
  end
end
