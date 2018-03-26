class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients
  has_many :ingredient_nutrients, dependent: :destroy
  belongs_to :location
  belongs_to :unit

  validates :name, uniqueness: true, presence: true
  validates :location_id, presence: true

  before_save StripUserInputCallback.new(['name', 'ndbno'])
  before_save :format_name

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

  def missing_nutritional_info?
    self.ndbno && IngredientNutrient.where(ingredient: self).empty?
  end

  private

  def format_name
    chomp_from_name = /, {,1} {,1}(GTIN|UPC): .+/.match(name)
    if chomp_from_name
      self.name = name.chomp(chomp_from_name[0])
    end
    self.name = name.capitalize
  end
end
