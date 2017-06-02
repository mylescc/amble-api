class CreateWalks < ActiveRecord::Migration[5.0]
  def change
    create_table :walks do |t|
      t.references :user, foreign_key: true
      t.references :route, foreign_key: true
      t.integer :distance_complete_km, null: false, default: 0
      t.integer :steps_complete, null: false, default: 0
      t.datetime :started_at
      t.datetime :completed_at

      t.timestamps
    end
  end
end
