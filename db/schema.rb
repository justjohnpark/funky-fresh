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

ActiveRecord::Schema.define(version: 20141016133947) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: true do |t|
    t.string   "name"
    t.string   "location",        default: "The Cookie Jar"
    t.date     "expiration_date"
    t.integer  "pantry_id_id"
    t.integer  "prototype_id_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["pantry_id_id"], name: "index_items_on_pantry_id_id", using: :btree
  add_index "items", ["prototype_id_id"], name: "index_items_on_prototype_id_id", using: :btree

  create_table "pantries", force: true do |t|
    t.integer  "creator_id_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pantries", ["creator_id_id"], name: "index_pantries_on_creator_id_id", using: :btree

  create_table "pantry_participations", force: true do |t|
    t.integer  "user_id_id"
    t.integer  "pantry_id_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pantry_participations", ["pantry_id_id"], name: "index_pantry_participations_on_pantry_id_id", using: :btree
  add_index "pantry_participations", ["user_id_id"], name: "index_pantry_participations_on_user_id_id", using: :btree

  create_table "prototypes", force: true do |t|
    t.string   "name"
    t.integer  "shelf_life"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
