module Walks
  class SingleSerializer
    attr_reader :walk

    def initialize(walk)
      @walk = walk
    end

    def as_json(_options = {})
      {
        id: walk.id,
        name: walk.name,
        distance_total_km: walk.distance_total_km,
        distance_complete_km: walk.distance_complete_km,
        distance_left_km: walk.distance_left_km,
        steps_total: walk.steps_total,
        steps_complete: walk.steps_complete,
        steps_left: walk.steps_left,
        started_at: walk.started_at,
        completed_at: walk.completed_at,
        status: walk.status
      }
    end
  end
end
