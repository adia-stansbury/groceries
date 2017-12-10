class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient
  belongs_to :location
  belongs_to :unit

  validates :recipe_id, :ingredient_id, presence: true

  scope :includes_ingredient_unit, -> {
    includes(:ingredient, :unit).order('ingredients.name')
  }
end

