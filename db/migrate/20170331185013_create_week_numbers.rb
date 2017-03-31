class CreateWeekNumbers < ActiveRecord::Migration[5.0]
  def change
    create_table :week_numbers do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
