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

ActiveRecord::Schema[7.0].define(version: 2022_12_18_075438) do
  create_table "sleep_records", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "duration", default: 0, null: false
    t.integer "hours", default: 0, null: false
    t.integer "minutes", default: 0, null: false
    t.integer "seconds", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.datetime "started_at", null: false
    t.datetime "ended_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sleep_records_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_followers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "following_user_id", null: false
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["following_user_id"], name: "index_users_followers_on_following_user_id"
    t.index ["user_id", "following_user_id"], name: "unique_index_on_user_id_and_following_user_id", unique: true
    t.index ["user_id"], name: "index_users_followers_on_user_id"
  end

  add_foreign_key "sleep_records", "users"
  add_foreign_key "users_followers", "users"
  add_foreign_key "users_followers", "users", column: "following_user_id"
end
