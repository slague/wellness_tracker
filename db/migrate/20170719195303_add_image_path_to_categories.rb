class AddImagePathToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :image_path, :string
  end
end
