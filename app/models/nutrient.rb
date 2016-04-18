class Nutrient < ActiveRecord::Base
  has_many :ingredient_nutrients, dependent: :destroy
  has_many :ingredients, through: :ingredient_nutrients

  validates :name, uniqueness: true, presence: true
end 
