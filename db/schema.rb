# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_28_071827) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "connections", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "store_id"], name: "index_connections_on_user_id_and_store_id", unique: true
  end

  create_table "stampcard_contents", force: :cascade do |t|
    t.bigint "store_id"
    t.integer "add_stamp_count"
    t.integer "max_stamp_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_stampcard_contents_on_store_id"
  end

  create_table "stampcards", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "stampcard_content_id"
    t.integer "stamp_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stampcard_content_id"], name: "index_stampcards_on_stampcard_content_id"
    t.index ["user_id"], name: "index_stampcards_on_user_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "email"
    t.string "name"
    t.string "address"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_stores_on_email", unique: true
    t.index ["reset_password_token"], name: "index_stores_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_stores_on_uid_and_provider", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "email", null: false
    t.string "name", null: false
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "stampcard_contents", "stores"
  add_foreign_key "stampcards", "stampcard_contents"
  add_foreign_key "stampcards", "users"
end
