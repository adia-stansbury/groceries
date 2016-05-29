module NutrientIntake
  extend ActiveSupport::Concern

  module ClassMethods
    def nutrient_intake(recipe_ids)
      IngredientNutrient.connection.select_all(
        "SELECT nutrients.id, nutrients.name, ingredient_nutrients.unit AS amt_consumed_unit, sum((value/100)*amount_in_grams) AS amt_consumed 
          FROM ingredient_nutrients 
          JOIN recipe_ingredients 
          ON recipe_ingredients.ingredient_id = ingredient_nutrients.ingredient_id 
          JOIN nutrients
          ON nutrients.id = ingredient_nutrients.nutrient_id
          WHERE recipe_ingredients.recipe_id = #{recipe_ids}
          GROUP BY nutrients.id, nutrients.name, amt_consumed_unit
          ORDER BY nutrients.name
        "
      ) 
    end  
  end 
end 

