class DropMealPlanRecipeDays < ActiveRecord::Migration[5.0]
  def up
    drop_table :meal_plan_recipe_days
  end

  def down
    create_table :meal_plan_recipe_days do |t|
      t.date :date
    end

    add_reference :meal_plan_recipe_days, :meal_plan_recipe, index: true, foreign_key: true
  end
end
