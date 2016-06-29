# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160422181517) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "game_id"
  end

  create_table "challenge_states", force: :cascade do |t|
    t.integer  "state"
    t.integer  "challenge_id"
    t.integer  "division_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "challenge_states", ["challenge_id"], name: "index_challenge_states_on_challenge_id"
  add_index "challenge_states", ["division_id"], name: "index_challenge_states_on_division_id"

  create_table "challenges", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "point_value"
    t.integer  "shares" # this is the total shares (i.e. sum of all user's shares for this challenge)
    t.integer  "share_increment" # This is the number of shares that each user will get when they complete it
    t.integer  "share_decrement" # This is how much the share_increment will decrease after each elapsed time increment
    t.integer  "elapsed_time" # this is the amount of time in hours before an action is taken on shares (i.e. share_increment decreased by share_decrement after this amount of time)
    t.datetime "share_updated_at" # time when the share_increment field was last updated
    t.integer  "point_increment" # this is the number of points the challenge will increase by if it hasn't been solved in point_elapsed_time
    t.integer  "point_elapsed_time" # this is the amount of time in hours before the amount of points should raise b/c it hasn't been solved
    t.datetime "point_updated_at" # time when the points was last raised due to no solves
    t.datetime "solved_at" # time when the challenge was first solved
    t.integer  "starting_state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.string   "achievement_name"
  end

  create_table "divisions", force: :cascade do |t|
    t.string   "name"
    t.integer  "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "divisions", ["game_id"], name: "index_divisions_on_game_id"

  create_table "feed_items", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "challenge_id"
    t.string   "text"
    t.integer  "point_value"
    t.integer  "flag_id"
    t.integer  "division_id"
    t.integer  "share_number"
  end

  add_index "feed_items", ["division_id"], name: "index_feed_items_on_division_id"
  add_index "feed_items", ["flag_id"], name: "index_feed_items_on_flag_id"

  create_table "flags", force: :cascade do |t|
    t.integer  "challenge_id"
    t.string   "flag"
    t.string   "api_request"
    t.string   "video_url"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "flags", ["challenge_id"], name: "index_flags_on_challenge_id"

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.datetime "start"
    t.datetime "stop"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "tos"
    t.string   "irc"
    t.boolean  "disable_vpn",                 default: false
    t.boolean  "disable_flags_an_hour_graph", default: false
  end

  create_table "keys", force: :cascade do |t|
    t.string   "name"
    t.text     "key"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "rails_admin_histories", force: :cascade do |t|
    t.string   "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories"

  create_table "states", force: :cascade do |t|
    t.integer  "state"
    t.integer  "challenge_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "states", ["challenge_id"], name: "index_states_on_challenge_id"

  create_table "submitted_flags", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "challenge_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
    t.datetime "messages_stamp"
    t.string   "tags"
    t.datetime "reset_password_sent_at"
    t.string   "display_name"
    t.string   "city"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "affiliation"
    t.boolean  "eligible",               default: true
    t.integer  "division_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
