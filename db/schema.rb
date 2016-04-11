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

ActiveRecord::Schema.define(version: 20160411234614) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredients", force: :cascade do |t|
    t.string  "name",        limit: 1000, null: false
    t.integer "location_id"
    t.integer "ndbno"
  end

  add_index "ingredients", ["name"], name: "ingredients_name_key", unique: true, using: :btree

  create_table "locations", force: :cascade do |t|
    t.string  "name",        limit: 1000, null: false
    t.integer "ordering",                 null: false
    t.text    "description"
  end

  add_index "locations", ["name"], name: "locations_name_key", unique: true, using: :btree
  add_index "locations", ["ordering"], name: "locations_aisle_key", unique: true, using: :btree

  create_table "recipe_ingredients", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "ingredient_id"
    t.string  "unit"
    t.integer "quantity"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name", limit: 1000, null: false
  end

  add_index "recipes", ["name"], name: "recipes_name_key", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
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

  add_foreign_key "ingredients", "locations", name: "ingredients_location_id_fkey"
  add_foreign_key "recipe_ingredients", "ingredients", name: "recipe_ingredients_ingredient_id_fkey"
  add_foreign_key "recipe_ingredients", "recipes", name: "recipe_ingredients_recipe_id_fkey"
end
