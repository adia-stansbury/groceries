class MealPlan < ActiveRecord::Vase
  has_many :meal_plan_recipes
  belongs_to :consumer
end 
