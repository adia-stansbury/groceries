class MealPlan < ActiveRecord::Base
  has_many :meal_plan_recipes
  belongs_to :consumer
end 
