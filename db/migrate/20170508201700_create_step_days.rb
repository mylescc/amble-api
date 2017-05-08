class CreateStepDays < ActiveRecord::Migration[5.0]
  def change
    create_table :step_days do |t|
      t.integer :steps
      t.date :date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
