class Consumer < ActiveRecord::Base
  has_many :consumer_recipes, dependent: :destroy
  has_many :recipes, through: :consumer_recipes
  has_many :meal_plans, dependent: :destroy
  
  validates :name, uniqueness: true, presence: true
end 
