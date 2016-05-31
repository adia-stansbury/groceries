class MealPlanRecipe < ActiveRecord::Vase
  belongs_to :meal_plan
  belongs_to :recipe
end 
