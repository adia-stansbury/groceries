class Recipe < ActiveRecord::Base
  include NutrientIntake

  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :consumer_recipes, dependent: :destroy
  has_many :meal_plan_recipes, dependent: :destroy
  has_many :meal_plan, through: :meal_plan_recipes
  has_many :consumers, through: :consumer_recipes
  before_save :capitalize_recipe_name!

  validates :name, uniqueness: true, presence: true

  private

  def capitalize_recipe_name!
    word_array = self.name.split.each { |word| word.capitalize! }
    self.name = word_array.join(' ')
  end 
end
