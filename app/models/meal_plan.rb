class MealPlan < ActiveRecord::Base
  has_many :meal_plan_recipes, dependent: :destroy
  has_many :recipes, through: :meal_plan_recipes
  belongs_to :consumer

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
end 
