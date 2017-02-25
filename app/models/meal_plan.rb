class MealPlan < ActiveRecord::Base
  has_many :meal_plan_recipes, dependent: :destroy
  has_many :recipes, through: :meal_plan_recipes
  belongs_to :consumer

  def self.shopping_list(sql_meal_plan_ids)
    RecipeIngredient.connection.select_all(
      "SELECT SUM(quantity) AS total_quantity, units.name AS unit, ingredients.name, STRING_AGG(distinct(recipes.name), '; ') AS recipe_names
        FROM recipe_ingredients
        JOIN recipes
        ON recipe_ingredients.recipe_id = recipes.id
        JOIN ingredients
        ON recipe_ingredients.ingredient_id = ingredients.id
        JOIN locations
        ON ingredients.location_id = locations.id
        JOIN units
        ON recipe_ingredients.unit_id = units.id
        JOIN meal_plan_recipes
        ON recipe_ingredients.recipe_id = meal_plan_recipes.recipe_id
        WHERE meal_plan_recipes.meal_plan_id IN (#{sql_meal_plan_ids})
        GROUP BY locations.ordering, ingredients.name, units.name
        ORDER BY locations.ordering
      "
    )
  end

  def nutrient_intake
    IngredientNutrient.connection.select_all(
      "SELECT nutrients.id, nutrients.name, ingredient_nutrients.unit AS amt_consumed_unit, sum((value/100)*amount_in_grams) AS amt_consumed
        FROM ingredient_nutrients
        JOIN recipe_ingredients
        ON recipe_ingredients.ingredient_id = ingredient_nutrients.ingredient_id
        JOIN nutrients
        ON nutrients.id = ingredient_nutrients.nutrient_id
        JOIN meal_plan_recipes
        ON recipe_ingredients.recipe_id = meal_plan_recipes.recipe_id
        WHERE meal_plan_recipes.meal_plan_id IN (#{id})
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
