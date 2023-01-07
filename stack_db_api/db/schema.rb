# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_01_06_122606) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "qiita_article_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["qiita_article_id"], name: "index_bookmarks_on_qiita_article_id"
    t.index ["user_id", "qiita_article_id"], name: "index_bookmarks_on_user_id_and_qiita_article_id", unique: true
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "image", null: false
    t.string "path", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
    t.index ["path"], name: "index_categories_on_path", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "qiita_article_id", null: false
    t.bigint "user_id", null: false
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["qiita_article_id"], name: "index_comments_on_qiita_article_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "qiita_article_likes", force: :cascade do |t|
    t.bigint "qiita_article_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["qiita_article_id"], name: "index_qiita_article_likes_on_qiita_article_id"
    t.index ["user_id", "qiita_article_id"], name: "index_qiita_article_likes_on_user_id_and_qiita_article_id", unique: true
    t.index ["user_id"], name: "index_qiita_article_likes_on_user_id"
  end

  create_table "qiita_articles", force: :cascade do |t|
    t.string "link", null: false
    t.string "title", null: false
    t.string "date", null: false
    t.integer "stock", null: false
    t.string "item_id", null: false
    t.string "image", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_qiita_articles_on_item_id", unique: true
    t.index ["link"], name: "index_qiita_articles_on_link", unique: true
  end

  create_table "qiita_category_maps", force: :cascade do |t|
    t.bigint "qiita_article_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_qiita_category_maps_on_category_id"
    t.index ["qiita_article_id"], name: "index_qiita_category_maps_on_qiita_article_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nickname", limit: 40, null: false
    t.text "description"
    t.string "uid", null: false
    t.string "avatar_key"
    t.string "twitter_username"
    t.string "github_username"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "bookmarks", "qiita_articles"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "comments", "qiita_articles"
  add_foreign_key "comments", "users"
  add_foreign_key "qiita_article_likes", "qiita_articles"
  add_foreign_key "qiita_article_likes", "users"
  add_foreign_key "qiita_category_maps", "categories"
  add_foreign_key "qiita_category_maps", "qiita_articles"
end
