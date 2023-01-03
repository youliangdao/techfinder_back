class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name,  null: false
      t.string :image, null: false
      t.string :path, null: false

      t.timestamps
    end
    add_index :categories, [:name], unique: true
    add_index :categories, [:path], unique: true
  end
end
