class Nutrient < ActiveRecord::Base
  include CleanUpUserInput
  include Fetcher
  include StoreDataInHash

  has_many :ingredient_nutrients, dependent: :destroy
  has_many :ingredients, through: :ingredient_nutrients
  has_many :consumer_nutrients, dependent: :destroy
  has_many :consumers, through: :consumer_nutrients
  has_many :food_nutrients, dependent: :destroy
  has_many :foods, through: :food_nutrients
  belongs_to :nutrient_group
  belongs_to :unit

  validates :name, uniqueness: true, presence: true

  def self.upper_limit(nutrients_upper_limit, nutrient_name)
    nutrients_upper_limit[nutrient_name]
  end 

  def self.weekly_upper_limit(upper_limit)
    upper_limit.present? ? (upper_limit * 7) : ''  
  end 
end 
