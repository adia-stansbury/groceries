class AddColumnCounttoMealPlanRecipes < ActiveRecord::Migration
  def change
    add_column :meal_plan_recipes, :number_of_recipes, :real, default: 1
  end
end
