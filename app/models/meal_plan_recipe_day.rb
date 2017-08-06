class MealPlanRecipeDay < ActiveRecord::Base
  belongs_to :meal_plan_recipe

  validates :meal_plan_recipe, presence: true
  validates :date, presence: true

  def self.build(meal_plan_recipes, recipe_ids_dates)
    new_rows = []
    meal_plan_recipes.each do |meal_plan_recipe|
      recipe_dates = recipe_ids_dates[meal_plan_recipe.recipe_id]
      if recipe_dates
        recipe_dates.each do |date|
          new_rows << { meal_plan_recipe_id: meal_plan_recipe.id, date: date }
        end
      end
    end
    new_rows
  end

  def self.fetch_just_mealplan_dates(all_mealplan_info)
    all_mealplan_info[:mealplan_dates]
  end

  def self.fetch_recipe_ids_date_hash(mealplan_with_recipe_ids)
    recipe_dates = {}
    mealplan_with_recipe_ids.values.each do |value|
      recipe_id = value[:recipe_id]
        recipe_dates[recipe_id] = value[:dates]
    end
    recipe_dates
  end
end
