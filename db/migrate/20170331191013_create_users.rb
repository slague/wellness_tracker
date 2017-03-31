class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.integer :census_uid

      t.timestamps null: false
    end
  end
end
