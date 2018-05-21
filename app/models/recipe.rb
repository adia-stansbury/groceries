class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :consumer_recipes, dependent: :destroy
  has_many :meal_plan_recipes, dependent: :destroy
  has_many :meal_plans, through: :meal_plan_recipes
  has_many :consumers, through: :consumer_recipes

  before_save StripUserInputCallback.new(['name'])
  before_save :name_titleized

  validates :name, uniqueness: true, presence: true

  def nutrition
    Nutrition::RecipeQuery.new(self).nutrition
  end

  private

  def name_titleized
    self.name = name.titleize
  end
end
