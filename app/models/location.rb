class Location < ActiveRecord::Base
  has_many :ingredients, dependent: :destroy
  has_many :recipe_ingredients, through: :ingredients

  validates :name, uniqueness: true
end 
