class RoutesController < ApplicationController
  def index
    routes = Route.all
    render json: {
      data: Routes::IndexSerializer.new(routes).as_json,
      count: routes.count
    }
  end
end
