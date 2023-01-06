class CreateQiitaArticleLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :qiita_article_likes do |t|
      t.references :qiita_article, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :qiita_article_likes, [:user_id, :qiita_article_id], unique: true

  end
end
