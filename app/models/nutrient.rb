class Nutrient < ActiveRecord::Base
  include CleanUpUserInput
  include Fetcher

  has_many :ingredient_nutrients, dependent: :destroy
  has_many :ingredients, through: :ingredient_nutrients
  has_many :consumer_nutrients, dependent: :destroy
  has_many :food_nutrients, dependent: :destroy
  has_many :foods, through: :food_nutrients
  belongs_to :nutrient_group
  belongs_to :unit

  validates :name, uniqueness: true, presence: true

  def weekly_upper_limit
    self.upper_limit.present? ? (self.upper_limit * 7) : ''  
  end 
end 
