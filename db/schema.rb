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

ActiveRecord::Schema.define(version: 20150415024740) do

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

  add_index "bottles", ["wine_id"], name: "index_bottles_on_wine_id"

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
  end

end
