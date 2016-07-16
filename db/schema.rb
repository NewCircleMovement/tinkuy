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

ActiveRecord::Schema.define(version: 20160716160231) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_stat_statements"

  create_table "bids", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.integer  "amount"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "timeslot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "centers", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.integer  "max_members"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coupons", force: :cascade do |t|
    t.string   "code",              limit: 255
    t.string   "free_trial_length", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.text     "description"
    t.time     "starttime"
    t.integer  "week_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "startdate"
    t.integer  "duration"
    t.integer  "hour"
    t.integer  "minute"
    t.boolean  "confirmed",                default: false
    t.integer  "user_id"
    t.integer  "fruits_count"
    t.integer  "max_spaces"
    t.integer  "free_spaces"
  end

  create_table "fruitbaskets", force: :cascade do |t|
    t.integer  "owner_id"
    t.string   "owner_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fruits_count",             default: 0
  end

  create_table "fruits", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.integer  "fruitbasket_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.integer  "center_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "max_members"
    t.integer  "price"
    t.integer  "fruits_per_month",             default: 0
  end

  create_table "plans", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "stripe_id",          limit: 255
    t.float    "price"
    t.string   "interval",           limit: 255
    t.text     "features"
    t.boolean  "highlight"
    t.integer  "display_order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "max_recur_bookings"
    t.integer  "fruits_per_month"
    t.text     "description"
    t.integer  "max_members"
    t.integer  "membership_id"
  end

  create_table "recurring_bookings", force: :cascade do |t|
    t.integer  "day"
    t.time     "time"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "startdate"
    t.integer  "resource_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "duration"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255, null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.string   "stripe_id",          limit: 255
    t.integer  "plan_id"
    t.string   "last_four",          limit: 255
    t.integer  "coupon_id"
    t.string   "card_type",          limit: 255
    t.float    "current_price"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "old_plan_id"
    t.date     "old_plan_exit_date"
  end

  create_table "timeslots", force: :cascade do |t|
    t.integer  "resource_id"
    t.date     "startdate"
    t.time     "starttime"
    t.integer  "duration"
    t.boolean  "booked",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "day"
    t.boolean  "is_recurring", default: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",        null: false
    t.string   "encrypted_password",     limit: 255, default: "",        null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "firstname",              limit: 255
    t.string   "surname",                limit: 255
    t.boolean  "confirm_payment",                    default: false
    t.string   "status",                 limit: 50,  default: "pending"
    t.boolean  "admin",                              default: false
    t.integer  "membertype"
    t.integer  "membership_id"
    t.boolean  "admin_info",                         default: false
    t.boolean  "therapist",                          default: false
    t.text     "therapist_description"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
