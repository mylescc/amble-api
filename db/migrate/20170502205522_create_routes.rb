class CreateRoutes < ActiveRecord::Migration[5.0]
  def change
    create_table :routes do |t|
      t.string :name, null: false, default: ""
      t.text :description, null: false, default: ""
      t.integer :distance_km, null: false, default: 0
      t.integer :distance_steps, limit: 8, null: false, default: 0

      t.timestamps
    end
  end
end
