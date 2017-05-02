class Route < ApplicationRecord

  def as_json(_options = {})
    {
      id: id,
      name: name,
      description: description,
      distance_km: distance_km,
      distance_steps: distance_steps
    }
  end
end
