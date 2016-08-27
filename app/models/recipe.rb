class Recipe < ActiveRecord::Base
  include SingleRecipe

  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :consumer_recipes, dependent: :destroy
  has_many :meal_plan_recipes, dependent: :destroy
  has_many :meal_plans, through: :meal_plan_recipes
  has_many :consumers, through: :consumer_recipes

  before_save :capitalize_recipe_name!
  before_save :remove_extraneous_characters

  validates :name, uniqueness: true, presence: true

  private

  def capitalize_recipe_name!
    word_array = self.name.split.each { |word| word.capitalize! }
    self.name = word_array.join(' ')
  end 
  
  def remove_extraneous_characters
    name.chomp!
    name.strip!
  end 
end
