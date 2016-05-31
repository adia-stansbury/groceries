class CreateMealPlanRecipes < ActiveRecord::Migration
  def change
    create_table :meal_plan_recipes do |t|
      t.integer :recipe_id
      t.integer :meal_plan_id
    end
  end
end
