class Nutrient < ActiveRecord::Base
  has_many :ingredient_nutrients
  has_many :ingredients, through: :ingredient_nutrients

  validates :name, uniqueness: true, presence: true
end 
