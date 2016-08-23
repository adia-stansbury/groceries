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

ActiveRecord::Schema.define(version: 20160823213226) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "consumer_recipes", force: :cascade do |t|
    t.integer "consumer_id", null: false
    t.integer "recipe_id",   null: false
  end

  create_table "consumers", force: :cascade do |t|
    t.string "name"
  end

  create_table "food_sources", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "ingredient_nutrients", force: :cascade do |t|
    t.float   "value",         null: false
    t.string  "unit",          null: false
    t.integer "nutrient_id",   null: false
    t.integer "ingredient_id", null: false
  end

  add_index "ingredient_nutrients", ["ingredient_id"], name: "index_ingredient_nutrients_on_ingredient_id", using: :btree
  add_index "ingredient_nutrients", ["nutrient_id"], name: "index_ingredient_nutrients_on_nutrient_id", using: :btree

  create_table "ingredients", force: :cascade do |t|
    t.string  "name",                             limit: 1000, null: false
    t.integer "location_id"
    t.string  "ndbno"
    t.integer "food_source_id"
    t.float   "measuring_amount"
    t.float   "num_of_grams_in_measuring_amount"
    t.integer "unit_id"
    t.text    "note"
  end

  add_index "ingredients", ["name"], name: "ingredients_name_key", unique: true, using: :btree

  create_table "locations", force: :cascade do |t|
    t.string  "name",        limit: 1000, null: false
    t.integer "ordering",                 null: false
    t.text    "description"
  end

  add_index "locations", ["name"], name: "locations_name_key", unique: true, using: :btree
  add_index "locations", ["ordering"], name: "locations_aisle_key", unique: true, using: :btree

  create_table "meal_plan_recipes", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "meal_plan_id"
    t.float   "number_of_recipes"
  end

  create_table "meal_plans", force: :cascade do |t|
    t.integer  "consumer_id"
    t.datetime "created_at"
  end

  create_table "nutrient_groups", force: :cascade do |t|
    t.string "name"
  end

  create_table "nutrients", force: :cascade do |t|
    t.string  "name",     null: false
    t.integer "group_id"
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "ingredient_id"
    t.float   "quantity"
    t.float   "amount_in_grams", default: 0.0, null: false
    t.integer "unit_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name",               limit: 1000, null: false
    t.float  "number_of_servings"
    t.text   "note"
  end

  add_index "recipes", ["name"], name: "recipes_name_key", unique: true, using: :btree

  create_table "units", force: :cascade do |t|
    t.string "name"
  end

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

  add_foreign_key "ingredient_nutrients", "ingredients"
  add_foreign_key "ingredient_nutrients", "nutrients"
  add_foreign_key "ingredients", "food_sources"
  add_foreign_key "ingredients", "locations", name: "ingredients_location_id_fkey"
  add_foreign_key "ingredients", "units"
  add_foreign_key "recipe_ingredients", "ingredients", name: "recipe_ingredients_ingredient_id_fkey"
  add_foreign_key "recipe_ingredients", "recipes", name: "recipe_ingredients_recipe_id_fkey"
  add_foreign_key "recipe_ingredients", "units"
end
