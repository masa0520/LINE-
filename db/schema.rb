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

ActiveRecord::Schema[7.0].define(version: 2023_04_28_132221) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_bookmarks_on_post_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_genres_on_name", unique: true
  end

  create_table "line_posts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_line_posts_on_post_id"
    t.index ["user_id"], name: "index_line_posts_on_user_id"
  end

  create_table "meanings", force: :cascade do |t|
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "post_id"
    t.index ["post_id"], name: "index_meanings_on_post_id"
    t.index ["user_id"], name: "index_meanings_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "genre_id", null: false
    t.datetime "set_time"
    t.index ["genre_id"], name: "index_posts_on_genre_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "word_meanings", force: :cascade do |t|
    t.bigint "word_id", null: false
    t.bigint "meaning_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "post_id"
    t.index ["meaning_id"], name: "index_word_meanings_on_meaning_id"
    t.index ["post_id"], name: "index_word_meanings_on_post_id"
    t.index ["word_id"], name: "index_word_meanings_on_word_id"
  end

  create_table "word_memories", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "word_id"
    t.bigint "meaning_id"
    t.bigint "word_meaning_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meaning_id"], name: "index_word_memories_on_meaning_id"
    t.index ["user_id"], name: "index_word_memories_on_user_id"
    t.index ["word_id"], name: "index_word_memories_on_word_id"
    t.index ["word_meaning_id"], name: "index_word_memories_on_word_meaning_id"
  end

  create_table "words", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "post_id"
    t.index ["post_id"], name: "index_words_on_post_id"
    t.index ["user_id"], name: "index_words_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookmarks", "posts"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "line_posts", "posts"
  add_foreign_key "line_posts", "users"
  add_foreign_key "meanings", "posts"
  add_foreign_key "meanings", "users"
  add_foreign_key "posts", "genres"
  add_foreign_key "posts", "users"
  add_foreign_key "word_meanings", "meanings"
  add_foreign_key "word_meanings", "posts"
  add_foreign_key "word_meanings", "words"
  add_foreign_key "word_memories", "meanings"
  add_foreign_key "word_memories", "users"
  add_foreign_key "word_memories", "word_meanings"
  add_foreign_key "word_memories", "words"
  add_foreign_key "words", "posts"
  add_foreign_key "words", "users"
end
