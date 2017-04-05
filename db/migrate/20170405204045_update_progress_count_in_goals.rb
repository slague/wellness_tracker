class UpdateProgressCountInGoals < ActiveRecord::Migration[5.0]
  def change
    change_column :goals, :progress_count, :integer, default: 0
  end
end
