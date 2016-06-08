class MealPlan < ActiveRecord::Base
  belongs_to :consumer
  has_many :meal_plan_recipes, dependent: :destroy
end 
