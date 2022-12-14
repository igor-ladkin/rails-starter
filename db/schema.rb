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

ActiveRecord::Schema[7.0].define(version: 2022_11_11_181251) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts_users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_accounts_users_on_name", unique: true
  end

  create_table "content_comments", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.bigint "post_id", null: false
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_content_comments_on_author_id"
    t.index ["post_id"], name: "index_content_comments_on_post_id"
  end

  create_table "content_posts", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.string "title", null: false
    t.text "text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_content_posts_on_author_id"
  end

  create_table "content_reactions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kind"], name: "index_content_reactions_on_kind"
    t.index ["post_id"], name: "index_content_reactions_on_post_id"
    t.index ["user_id", "post_id"], name: "index_content_reactions_on_user_id_and_post_id", unique: true
    t.index ["user_id"], name: "index_content_reactions_on_user_id"
  end

  add_foreign_key "content_comments", "accounts_users", column: "author_id"
  add_foreign_key "content_comments", "content_posts", column: "post_id"
  add_foreign_key "content_posts", "accounts_users", column: "author_id"
  add_foreign_key "content_reactions", "accounts_users", column: "user_id"
  add_foreign_key "content_reactions", "content_posts", column: "post_id"
end
