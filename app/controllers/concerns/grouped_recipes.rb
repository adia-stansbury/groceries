module GroupedRecipes
  extend ActiveSupport::Concern

  module ClassMethods
    def nutrient_intake(meal_plan_id)
      IngredientNutrient.connection.select_all(
        "SELECT nutrients.id, nutrients.name, ingredient_nutrients.unit AS amt_consumed_unit, sum((value/100)*amount_in_grams) AS amt_consumed 
          FROM ingredient_nutrients 
          JOIN recipe_ingredients 
          ON recipe_ingredients.ingredient_id = ingredient_nutrients.ingredient_id 
          JOIN nutrients
          ON nutrients.id = ingredient_nutrients.nutrient_id
          JOIN meal_plan_recipes
          ON recipe_ingredients.recipe_id = meal_plan_recipes.recipe_id
          WHERE meal_plan_recipes.meal_plan_id IN (#{meal_plan_id})
          GROUP BY nutrients.id, nutrients.name, amt_consumed_unit
          ORDER BY nutrients.name
        "
      ) 
    end  
  end 
end 
