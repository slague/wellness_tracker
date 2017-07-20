class AddCohortToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :cohort, :string
  end
end
