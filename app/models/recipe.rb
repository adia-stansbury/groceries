class Recipe < ActiveRecord::Base
  include CleanUpUserInput

  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :consumer_recipes, dependent: :destroy
  has_many :meal_plan_recipes, dependent: :destroy
  has_many :meal_plans, through: :meal_plan_recipes
  has_many :consumers, through: :consumer_recipes

  before_save :capitalize_recipe_name!

  validates :name, uniqueness: true, presence: true

  def self.dictionary_name_id(names)
    where(name: names).pluck(:name, :id).to_h
  end

  def nutrient_intake
    IngredientNutrient.connection.select_all(
      "SELECT nutrients.id, nutrients.name, ingredient_nutrients.unit AS amt_consumed_unit, sum((value/100)*amount_in_grams) AS amt_consumed
        FROM ingredient_nutrients
        JOIN recipe_ingredients
        ON recipe_ingredients.ingredient_id = ingredient_nutrients.ingredient_id
        JOIN nutrients
        ON nutrients.id = ingredient_nutrients.nutrient_id
        WHERE recipe_ingredients.recipe_id IN (#{id})
        GROUP BY nutrients.id, nutrients.name, amt_consumed_unit
        ORDER BY nutrients.name
      "
    )
  end

  private

  def capitalize_recipe_name!
    word_array = self.name.split.each { |word| word.capitalize! }
    self.name = word_array.join(' ')
  end
end
