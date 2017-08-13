class ReplaceNumberOfRecipesWithDateInMealPlanRecipe < ActiveRecord::Migration[5.0]
  def change
    remove_column :meal_plan_recipes, :number_of_recipes, :real
    add_column :meal_plan_recipes, :date, :date
  end
end
