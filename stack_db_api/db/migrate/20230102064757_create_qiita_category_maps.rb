class CreateQiitaCategoryMaps < ActiveRecord::Migration[6.1]
  def change
    create_table :qiita_category_maps do |t|
      t.references :qiita_article, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
