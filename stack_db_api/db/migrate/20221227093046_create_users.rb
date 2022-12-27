class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :nickname,             null: false, limit: 40
      t.text :description,            limit: 160
      t.string :uid,                  unique: true
      t.string :avatar_key,           unique: true
      t.string :twitter_username
      t.string :github_username

      t.timestamps
    end
  end
end
