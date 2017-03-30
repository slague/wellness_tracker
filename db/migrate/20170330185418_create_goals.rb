class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.string :description
      t.integer :progress_count
      t.integer :total_goal_count
      t.references :category, index: true, foreign_key: true

      t.timestamps
    end
  end
end
