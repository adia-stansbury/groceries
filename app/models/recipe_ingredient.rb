class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient
  belongs_to :location

  validates :recipe_id, presence: true
  validates :ingredient_id, presence: true
end

