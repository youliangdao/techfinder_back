class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|
      t.string :link,  null: false
      t.string :title, null: false
      t.string :date,  null: false
      t.integer :stock, null: false
      t.string :item_id
      t.string :media_name, null: false
      t.string :media_image, null: false
      t.string :image, null: false

      t.timestamps
    end
    add_index :articles, [:link], unique: true
  end
end
