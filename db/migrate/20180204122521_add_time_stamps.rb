class AddTimeStamps < ActiveRecord::Migration[5.1]
  def change
    [
      :consumer_nutrients,
      :consumers,
      :ingredient_nutrients,
      :ingredients,
      :locations,
      :meal_plan_recipes,
      :nutrient_groups,
      :nutrients,
      :recipe_ingredients,
      :recipes,
      :units
    ].each do |table|
      add_column table, :created_at, :datetime
      add_column table, :updated_at, :datetime
    end
    add_column :meal_plans, :updated_at, :datetime
  end
end
