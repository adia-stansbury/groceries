class AddIndicesToMealPlanRecipe < ActiveRecord::Migration[5.0]
  def change
    add_index :meal_plan_recipes, [:meal_plan_id, :date, :recipe_id]
  end
end
