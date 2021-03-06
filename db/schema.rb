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

ActiveRecord::Schema.define(version: 20170729210737) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image_path"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "goals", force: :cascade do |t|
    t.string   "description"
    t.integer  "progress_count",   default: 0
    t.integer  "total_goal_count"
    t.integer  "category_id"
    t.integer  "user_id"
    t.integer  "week_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["category_id"], name: "index_goals_on_category_id", using: :btree
    t.index ["user_id"], name: "index_goals_on_user_id", using: :btree
    t.index ["week_id"], name: "index_goals_on_week_id", using: :btree
  end

  create_table "mods", force: :cascade do |t|
    t.string "inning"
  end

  create_table "reminders", force: :cascade do |t|
    t.string   "phone_number"
    t.datetime "time"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "census_uid"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "role",                default: 0
    t.string   "census_access_token"
    t.string   "cohort"
    t.integer  "github_id"
    t.string   "name"
    t.string   "phone_number"
    t.boolean  "wants_reminder"
  end

  create_table "week_numbers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weeks", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "week_number_id"
    t.integer  "mod_id"
    t.index ["mod_id"], name: "index_weeks_on_mod_id", using: :btree
    t.index ["week_number_id"], name: "index_weeks_on_week_number_id", using: :btree
  end

  create_table "winners", force: :cascade do |t|
    t.integer "user_id"
    t.integer "week_id"
    t.index ["user_id"], name: "index_winners_on_user_id", using: :btree
    t.index ["week_id"], name: "index_winners_on_week_id", using: :btree
  end

  add_foreign_key "goals", "categories"
  add_foreign_key "goals", "users"
  add_foreign_key "goals", "weeks"
  add_foreign_key "weeks", "mods"
  add_foreign_key "weeks", "week_numbers"
  add_foreign_key "winners", "users"
  add_foreign_key "winners", "weeks"
end
