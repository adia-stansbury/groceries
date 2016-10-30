class IngredientNutrient < ActiveRecord::Base
  include NutrientTargets

  belongs_to :ingredient
  belongs_to :nutrient

  validates :value, presence: true
  validates :unit, presence: true
  validates :nutrient_id, uniqueness: { scope: :ingredient_id, 
    message: 'nutrient and ing combo shoud be unique'
  }, presence: true
  validates :ingredient_id, presence: true

  def self.nutrition(ingredient_id, nutrient_ids)
    self.includes(:nutrient).where(
      ingredient_id: ingredient_id, 
      nutrient_id: nutrient_ids
    ).order('nutrients.name')
  end 
end 
