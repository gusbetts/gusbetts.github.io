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

ActiveRecord::Schema.define(version: 20110106073136) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_records", force: :cascade do |t|
    t.integer  "gameroom_id"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "completed",   default: true
  end

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.boolean  "is_private", default: false
    t.boolean  "permanent",  default: false
    t.boolean  "active",     default: true
  end

  create_table "user_game_records", force: :cascade do |t|
    t.integer "game_record_id"
    t.integer "user_id"
    t.integer "num_letters"
    t.text    "data"
    t.integer "rank"
  end

  create_table "users", force: :cascade do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "game_id"
    t.integer  "wins",            default: 0
    t.integer  "games_completed", default: 0
  end

end
