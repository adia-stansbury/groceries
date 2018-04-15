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
    Ingredient
    .select(
      'nutrients.id',
      'nutrients.name',
      'ingredient_nutrients.unit AS amt_consumed_unit',
      'value AS amt_consumed'
    )
    .join(ingredient_nutrients: :nutrient)
    .where(id: id)
    .group('nutrients.id', 'nutrients.name', 'amt_consumed_unit', value)
    .order('nutrients.name')
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
