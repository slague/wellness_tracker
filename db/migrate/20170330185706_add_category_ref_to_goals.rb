class AddCategoryRefToGoals < ActiveRecord::Migration[5.0]
  def change
    add_reference :goals, :category, foreign_key: true
  end
end
