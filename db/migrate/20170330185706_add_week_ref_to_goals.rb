class AddWeekRefToGoals < ActiveRecord::Migration[5.0]
  def change
    add_reference :goals, :week, index: true, foreign_key: true
  end
end
