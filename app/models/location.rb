class Location < ActiveRecord::Base
  include CleanUpUserInput

  has_many :ingredients
  has_many :recipe_ingredients, through: :ingredients, dependent: :destroy

  validates :name, uniqueness: true, presence: true
end 
