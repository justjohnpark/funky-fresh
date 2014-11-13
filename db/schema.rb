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

ActiveRecord::Schema.define(version: 20141113201405) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "invites", force: true do |t|
    t.string   "email"
    t.integer  "pantry_id"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invites", ["pantry_id"], name: "index_invites_on_pantry_id", using: :btree
  add_index "invites", ["recipient_id"], name: "index_invites_on_recipient_id", using: :btree
  add_index "invites", ["sender_id"], name: "index_invites_on_sender_id", using: :btree

  create_table "items", force: true do |t|
    t.date     "expiration_date"
    t.integer  "pantry_id"
    t.integer  "prototype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["pantry_id"], name: "index_items_on_pantry_id", using: :btree
  add_index "items", ["prototype_id"], name: "index_items_on_prototype_id", using: :btree

  create_table "pantries", force: true do |t|
    t.string   "name"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pantries", ["creator_id"], name: "index_pantries_on_creator_id", using: :btree

  create_table "pantry_participations", force: true do |t|
    t.integer  "user_id"
    t.integer  "pantry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pantry_participations", ["pantry_id"], name: "index_pantry_participations_on_pantry_id", using: :btree
  add_index "pantry_participations", ["user_id", "pantry_id"], name: "index_pantry_participations_on_user_id_and_pantry_id", unique: true, using: :btree
  add_index "pantry_participations", ["user_id"], name: "index_pantry_participations_on_user_id", using: :btree

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
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

end
