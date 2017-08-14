class RequireMealPlanRecipeColumns < ActiveRecord::Migration[5.0]
  def change
    change_column_null :meal_plan_recipes, :recipe_id, false
    change_column_null :meal_plan_recipes, :meal_plan_id, false
    change_column_null :meal_plan_recipes, :date, false
  end
end
