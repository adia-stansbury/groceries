class IngredientNutrient < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :nutrient

  validates :value, presence: true
  validates :unit, presence: true
end 
