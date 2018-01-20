class MealPlan < ActiveRecord::Base
  has_many :meal_plan_recipes, dependent: :destroy
  has_many :recipes, through: :meal_plan_recipes
  belongs_to :consumer

  validates :consumer, presence: true

  def self.info_from_calendar(events_items)
    info = { info_valid: [], recipe_names_not_in_db: [] }
    events_items.each do |event|
      recipe_date = event.start.date.to_date
      recipe_name = event.summary.strip.titleize
      recipe = Recipe.find_by(name: recipe_name)
      if recipe
        info[:info_valid] << {
          recipe_id: recipe.id,
          date: recipe_date
        }
      else
        info[:recipe_names_not_in_db] << recipe_name
      end
    end
    info
  end

  def dates
    meal_plan_recipes.order(:date).distinct.pluck(:date)
  end

  def recipes_for_date(date)
    meal_plan_recipes.includes(:recipe).where(date: date).order('recipes.name')
  end

  def nutrient_intake(start_date, end_date)
    IngredientNutrient.connection.select_all(
      "SELECT
          nutrients.id,
          nutrients.name,
          ingredient_nutrients.unit AS amt_consumed_unit,
          sum((value/100)*amount_in_grams) AS amt_consumed
        FROM ingredient_nutrients
        JOIN recipe_ingredients
        ON recipe_ingredients.ingredient_id = ingredient_nutrients.ingredient_id
        JOIN nutrients
        ON nutrients.id = ingredient_nutrients.nutrient_id
        JOIN meal_plan_recipes
        ON recipe_ingredients.recipe_id = meal_plan_recipes.recipe_id
        WHERE meal_plan_recipes.meal_plan_id = (#{id})
        AND meal_plan_recipes.date
        BETWEEN CAST('#{start_date}' AS date) AND CAST('#{end_date}' AS date)
        GROUP BY nutrients.id, nutrients.name, amt_consumed_unit
        ORDER BY nutrients.name
      "
    )
  end

  def nutrient_intake_from_custom_food(food, nutrient_name)
    if recipes.pluck(:name).include?(food.name)
      if food.nutrition[nutrient_name].present?
        return food.nutrition[nutrient_name]
      else
        return 0
      end
    else
      return 0
    end
  end
end
