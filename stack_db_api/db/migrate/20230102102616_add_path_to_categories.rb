class AddPathToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :path, :string, unique: true, null: false
  end
end
