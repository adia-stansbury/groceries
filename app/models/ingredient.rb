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

  def missing_nutritional_info?
    self.ndbno && IngredientNutrient.where(ingredient: self).empty?
  end

  def nutrition
    Nutrition::IngredientQuery.new(self).nutrition
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
