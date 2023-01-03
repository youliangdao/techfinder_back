class CreateQiitaArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :qiita_articles do |t|
      t.string :link,  null: false
      t.string :title, null: false
      t.string :date,  null: false
      t.integer :stock, null: false
      t.string :item_id, null: false

      t.timestamps
    end
    add_index :qiita_articles, [:link], unique: true
    add_index :qiita_articles, [:item_id], unique: true
  end
end
