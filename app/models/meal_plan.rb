class MealPlan < ActiveRecord::Base
  include GroupedRecipes

  has_many :meal_plan_recipes, dependent: :destroy
  has_many :recipes, through: :meal_plan_recipes
  belongs_to :consumer
end 
