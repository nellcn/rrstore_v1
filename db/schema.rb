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

ActiveRecord::Schema.define(version: 20150907033123) do

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "product_id", limit: 4
    t.integer  "amount",     limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "discounts", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "prod_qty",   limit: 4
    t.float    "discount",   limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "freebies", force: :cascade do |t|
    t.integer  "product_id",  limit: 4
    t.integer  "prod_qty",    limit: 4
    t.integer  "freebie_id",  limit: 4
    t.integer  "freebie_qty", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id",   limit: 4
    t.integer  "product_id", limit: 4
    t.integer  "prod_qty",   limit: 4
    t.float    "discount",   limit: 24
    t.float    "sub_pay",    limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.float    "prod_price", limit: 24
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.float    "total_pay",    limit: 24
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.datetime "payed_at"
    t.datetime "delivered_at"
    t.datetime "received_at"
    t.string   "address",      limit: 255
  end

  create_table "products", force: :cascade do |t|
    t.string   "prod_name",   limit: 255
    t.float    "prod_price",  limit: 24
    t.integer  "prod_amount", limit: 4
    t.text     "prod_desc",   limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "prod_img",    limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "password_digest", limit: 255
    t.string   "remember_token",  limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
