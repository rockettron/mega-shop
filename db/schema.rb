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

ActiveRecord::Schema.define(version: 20160922094205) do

  create_table "cart_items", force: :cascade do |t|
    t.integer  "quantity",   limit: 4, default: 1
    t.integer  "price",      limit: 4
    t.integer  "cart_id",    limit: 4
    t.integer  "product_id", limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "carts", force: :cascade do |t|
    t.boolean  "status",               default: true
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "quantity",   limit: 4, default: 1
    t.integer  "price",      limit: 4
    t.integer  "order_id",   limit: 4
    t.integer  "product_id", limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "adress",      limit: 255
    t.boolean  "paid",                    default: false
    t.integer  "amount",      limit: 4
    t.integer  "items_count", limit: 4
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.decimal  "price",                     precision: 10
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      limit: 255
    t.string   "last_name",       limit: 255
    t.integer  "balance",         limit: 4,   default: 0
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.integer  "orders_count",    limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

end
