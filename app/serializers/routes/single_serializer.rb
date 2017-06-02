module Routes
  class SingleSerializer
    attr_reader :route

    def initialize(route)
      @route = route
    end

    def as_json(_options = {})
      {
        id: route.id,
        name: route.name,
        description: route.description,
        distance_km: route.distance_km,
        distance_steps: route.distance_steps
      }
    end
  end
end
