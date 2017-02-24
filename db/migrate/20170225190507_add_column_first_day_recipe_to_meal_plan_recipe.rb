class AddColumnFirstDayRecipeToMealPlanRecipe < ActiveRecord::Migration[5.0]
  def change
    add_column :meal_plan_recipes, :first_day_recipe, :boolean, default: false
  end
end
