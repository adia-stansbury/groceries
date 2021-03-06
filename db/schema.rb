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

ActiveRecord::Schema.define(version: 20180204122521) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "consumer_nutrients", id: :serial, force: :cascade do |t|
    t.float "daily_rda"
    t.integer "consumer_id"
    t.integer "nutrient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["consumer_id"], name: "index_consumer_nutrients_on_consumer_id"
    t.index ["nutrient_id"], name: "index_consumer_nutrients_on_nutrient_id"
  end

  create_table "consumer_recipes", id: :serial, force: :cascade do |t|
    t.integer "consumer_id", null: false
    t.integer "recipe_id", null: false
  end

  create_table "consumers", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "weight_in_lbs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredient_nutrients", id: :serial, force: :cascade do |t|
    t.float "value", null: false
    t.string "unit", null: false
    t.integer "nutrient_id", null: false
    t.integer "ingredient_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["ingredient_id"], name: "index_ingredient_nutrients_on_ingredient_id"
    t.index ["nutrient_id"], name: "index_ingredient_nutrients_on_nutrient_id"
  end

  create_table "ingredients", id: :serial, force: :cascade do |t|
    t.string "name", limit: 1000, null: false
    t.integer "location_id", null: false
    t.string "ndbno"
    t.float "measuring_amount"
    t.float "num_of_grams_in_measuring_amount"
    t.integer "unit_id"
    t.text "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["location_id"], name: "index_ingredients_on_location_id"
    t.index ["name"], name: "ingredients_name_key", unique: true
  end

  create_table "locations", id: :serial, force: :cascade do |t|
    t.string "name", limit: 1000, null: false
    t.integer "ordering", null: false
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "locations_name_key", unique: true
    t.index ["ordering"], name: "locations_aisle_key", unique: true
  end

  create_table "meal_plan_recipes", id: :serial, force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.integer "meal_plan_id", null: false
    t.date "date", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["meal_plan_id", "date", "recipe_id"], name: "index_meal_plan_recipes_on_meal_plan_id_and_date_and_recipe_id"
  end

  create_table "meal_plans", id: :serial, force: :cascade do |t|
    t.integer "consumer_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nutrient_groups", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nutrients", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.integer "nutrient_group_id"
    t.float "upper_limit"
    t.integer "unit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["unit_id"], name: "index_nutrients_on_unit_id"
  end

  create_table "recipe_ingredients", id: :serial, force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.integer "ingredient_id", null: false
    t.float "quantity"
    t.float "amount_in_grams", default: 0.0, null: false
    t.integer "unit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipes", id: :serial, force: :cascade do |t|
    t.string "name", limit: 1000, null: false
    t.float "number_of_servings"
    t.text "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "recipes_name_key", unique: true
  end

  create_table "units", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "consumer_nutrients", "consumers"
  add_foreign_key "consumer_nutrients", "nutrients"
  add_foreign_key "ingredient_nutrients", "ingredients"
  add_foreign_key "ingredient_nutrients", "nutrients"
  add_foreign_key "ingredients", "locations", name: "ingredients_location_id_fkey"
  add_foreign_key "ingredients", "units"
  add_foreign_key "nutrients", "units"
  add_foreign_key "recipe_ingredients", "ingredients", name: "recipe_ingredients_ingredient_id_fkey"
  add_foreign_key "recipe_ingredients", "recipes", name: "recipe_ingredients_recipe_id_fkey"
  add_foreign_key "recipe_ingredients", "units"
end
