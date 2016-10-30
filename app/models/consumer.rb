class Consumer < ActiveRecord::Base
  include CleanUpUserInput
  include Fetcher

  has_many :consumer_recipes, dependent: :destroy
  has_many :recipes, through: :consumer_recipes
  has_many :meal_plans, dependent: :destroy
  has_many :consumer_nutrients, dependent: :destroy
  
  validates :name, uniqueness: true, presence: true
  validates :weight_in_lbs, presence: true
end 
