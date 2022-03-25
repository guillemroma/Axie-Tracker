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

ActiveRecord::Schema.define(version: 2022_03_25_141450) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "battles", force: :cascade do |t|
    t.string "result"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "team_id"
    t.string "battle_uuid"
    t.index ["team_id"], name: "index_battles_on_team_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "followers", force: :cascade do |t|
    t.bigint "followed_id"
    t.bigint "follower_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_followers_on_followed_id"
    t.index ["follower_id"], name: "index_followers_on_follower_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.bigint "team_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "hp"
    t.integer "morale"
    t.integer "speed"
    t.integer "skill"
    t.string "eyes"
    t.string "ears"
    t.string "back"
    t.string "mouth"
    t.string "horn"
    t.string "tail"
    t.string "image"
    t.string "axie_class"
    t.integer "axie_game_id"
    t.index ["team_id"], name: "index_pets_on_team_id"
  end

  create_table "rankings", force: :cascade do |t|
    t.integer "rank"
    t.string "scholar_name"
    t.integer "mmr"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teams", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "mmr"
    t.bigint "rank"
    t.bigint "current_slp"
    t.bigint "total_slp"
    t.bigint "last_claim"
    t.bigint "next_claim"
    t.string "ronin_address"
    t.string "scholar_name"
    t.float "win_rate"
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "tweets", force: :cascade do |t|
    t.string "content"
    t.integer "retweets"
    t.integer "likes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "photo"
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "followers", "users", column: "followed_id"
  add_foreign_key "followers", "users", column: "follower_id"
  add_foreign_key "pets", "teams"
  add_foreign_key "teams", "users"
end
