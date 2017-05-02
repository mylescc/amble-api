class RoutesController < ApplicationController
  def index
    routes = Route.all
    render json: {
      data: routes.as_json,
      count: routes.count
    }
  end
end
