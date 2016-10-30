class Unit < ActiveRecord::Base
  include CleanUpUserInput

  has_many :recipe_ingredients
  has_many :ingredients
  has_many :nutrients

  validates :name, uniqueness: true, presence: true
end 
