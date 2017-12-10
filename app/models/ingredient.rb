class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients
  has_many :ingredient_nutrients, dependent: :destroy
  belongs_to :location
  belongs_to :unit

  validates :name, uniqueness: true, presence: true
  validates :location_id, presence: true

  before_save StripUserInputCallback.new(['name', 'ndbno'])

  def nutrition
    Ingredient.connection.select_all(
      "SELECT nutrients.id, nutrients.name, ingredient_nutrients.unit AS amt_consumed_unit, value AS amt_consumed
        FROM ingredient_nutrients
        JOIN ingredients
        ON ingredients.id = ingredient_nutrients.ingredient_id
        JOIN nutrients
        ON nutrients.id = ingredient_nutrients.nutrient_id
        WHERE ingredient_nutrients.ingredient_id IN (#{id})
        GROUP BY nutrients.id, nutrients.name, amt_consumed_unit, value
        ORDER BY nutrients.name
      "
    )
  end
end
