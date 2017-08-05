module Api
  module V1
    class RoutesController < BaseController 
      def index
        routes = Route.all
        render json: {
          data: Routes::IndexSerializer.new(routes).as_json,
          count: routes.count
        }
      end
    end
  end
end
