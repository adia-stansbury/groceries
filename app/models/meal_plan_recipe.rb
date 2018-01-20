class MealPlanRecipe < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :meal_plan

  validates :recipe_id, :meal_plan_id, :date, presence: true
end
