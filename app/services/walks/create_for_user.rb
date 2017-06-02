module Walks
  class CreateForUser
    def call(user:, route_id:)
      route = Route.find_by(id: route_id.to_i)

      raise Walks::Error::RouteNotFound unless route
      check_route_status(user, route)

      user.walks.create!(
        route: route,
        started_at: Time.zone.now
      )
    end

    private

    def check_route_status(user, route)
      walk = user.walks.find_by(route: route)
      return unless walk
      raise Walks::Error::RouteAlreadyCompleted if walk.complete?
      raise Walks::Error::RouteAlreadyInProgress
    end
  end
end
