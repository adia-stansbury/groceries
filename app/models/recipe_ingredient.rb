class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient
  belongs_to :location
  belongs_to :unit

  validates :recipe_id, :ingredient_id, presence: true

  after_create :create_ingredient_nutrients,
    if: Proc.new { |recipe_ingredient| recipe_ingredient.ingredient.missing_nutritional_info? }

  scope :includes_ingredient_unit, -> {
    includes(:ingredient, :unit).order('ingredients.name')
  }

  private

  def create_ingredient_nutrients
    dictionary = Nutrient.name_id_dictionary
    nutrition = Nutrition.for_ingredient(self.ingredient)
    new_rows = FormatData.to_ingredient_nutrient_rows(nutrition, dictionary)
    self.ingredient.ingredient_nutrients.create(new_rows)
  end
end

