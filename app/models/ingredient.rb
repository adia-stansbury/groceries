class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :recipes
  belongs_to :location

  validates :name, uniqueness: true
end 
