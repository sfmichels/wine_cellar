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

ActiveRecord::Schema.define(version: 20150605225520) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bottles", force: true do |t|
    t.string   "purchased_from"
    t.decimal  "purchase_price", precision: 9, scale: 2
    t.date     "purchase_date"
    t.string   "location"
    t.date     "consumed_date"
    t.integer  "wine_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bottles", ["wine_id"], name: "index_bottles_on_wine_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vs_database_diagrams", id: false, force: true do |t|
    t.string   "name",     limit: 80
    t.text     "diadata"
    t.string   "comment",  limit: 1022
    t.text     "preview"
    t.string   "lockinfo", limit: 80
    t.datetime "locktime"
    t.string   "version",  limit: 80
  end

  create_table "wines", force: true do |t|
    t.string   "winery"
    t.string   "variety"
    t.integer  "vintage"
    t.string   "appellation"
    t.string   "vineyard"
    t.string   "winemaker"
    t.string   "alcohol_content"
    t.string   "color"
    t.boolean  "sparkling"
    t.string   "bottle_size"
    t.string   "country"
    t.integer  "maturity"
    t.integer  "drink_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "dessert"
    t.text     "my_notes"
    t.text     "other_notes"
    t.boolean  "non_vintage"
    t.string   "vintage_displayer"
    t.integer  "user_id"
  end

  add_index "wines", ["user_id"], name: "index_wines_on_user_id", using: :btree

end
