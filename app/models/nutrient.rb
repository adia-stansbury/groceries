class Nutrient < ActiveRecord::Base
  has_many :ingredient_nutrients, dependent: :destroy
  has_many :ingredients, through: :ingredient_nutrients
  belongs_to :nutrient_group

  validates :name, uniqueness: true, presence: true
end 
