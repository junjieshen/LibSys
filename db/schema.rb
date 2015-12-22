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

ActiveRecord::Schema.define(version: 20151005042046) do

  create_table "admins", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "preadmin",        default: false
    t.boolean  "active",          default: true
  end

  create_table "books", force: :cascade do |t|
    t.integer  "ISBN",        limit: 8
    t.text     "title"
    t.text     "description"
    t.text     "authors"
    t.text     "status"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "holder"
    t.boolean  "active",                default: true
  end

  add_index "books", ["ISBN"], name: "index_books_on_ISBN", unique: true

  create_table "histories", force: :cascade do |t|
    t.integer  "book_id"
    t.string   "member_email"
    t.string   "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "checkout_at"
    t.datetime "return_at"
  end

  create_table "members", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "active",          default: true
  end

  create_table "subscribes", force: :cascade do |t|
    t.string   "member_email"
    t.integer  "book_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string   "member_email"
    t.integer  "book_id"
    t.boolean  "active",       default: true
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "suggestions", force: :cascade do |t|
    t.string   "member_email"
    t.integer  "ISBN",         limit: 8
    t.string   "title"
    t.string   "description"
    t.string   "authors"
    t.boolean  "active",                 default: true
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

end
