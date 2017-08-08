module Frontend
  class RoutesController < BaseController
    def index
      @routes = Route.all
    end

    def show
      @route = Route.find(params[:id])
    end
  end
end
