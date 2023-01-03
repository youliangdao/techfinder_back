class AddIndexItemIdToQiitaArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :qiita_articles, :item_id, :string
    add_index :qiita_articles, :item_id, unique: true
  end
end
