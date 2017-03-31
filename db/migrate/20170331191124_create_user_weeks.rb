class CreateUserWeeks < ActiveRecord::Migration[5.0]
  def change
    create_table :user_weeks do |t|
      t.references :user, foreign_key: true
      t.references :week, foreign_key: true

      t.timestamps null: false
    end
  end
end
