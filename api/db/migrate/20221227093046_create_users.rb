class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :nickname,             null: false, limit: 40
      t.text :description,            limit: 160
      t.string :uid,                  null: false             
      t.string :avatar_key
      t.string :twitter_username
      t.string :github_username

      t.timestamps
    end
    add_index :users, [:uid], unique: true
  end
end
