class Unit < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients

  validates :name, uniqueness: true, presence: true
end 
