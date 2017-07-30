class CreateWinners < ActiveRecord::Migration[5.0]
  def change
    create_table :winners do |t|
      t.references :user, index: true, foreign_key: true
      t.references :week, index: true, foreign_key: true
    end
  end
end
