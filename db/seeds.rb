# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Route.create!(
  [
    {
      name: "M25 Walk",
      description: "A beautiful walk around the M25",
      distance_km: 188,
      distance_steps: 246719
    }
  ]
)
