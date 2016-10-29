class FoodNutrient < ActiveRecord::Base
  belongs_to :food
  belongs_to :nutrient

  validates :nutrient_amount, presence: true
  validates :food, uniqueness: { scope: :nutrient }
end 
