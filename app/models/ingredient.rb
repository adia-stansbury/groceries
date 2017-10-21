class Ingredient < ActiveRecord::Base
  include CleanUpUserInput

  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients
  has_many :ingredient_nutrients, dependent: :destroy
  belongs_to :location
  belongs_to :food_source
  belongs_to :unit

  validates :name, uniqueness: true, presence: true
  validates :location_id, presence: true

  private

  def format_ndbno
    ndbno.chomp!
    ndbno.strip!
    ndbno
  end
end
