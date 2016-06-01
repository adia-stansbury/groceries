class Consumer < ActiveRecord::Base
  has_many :consumer_recipes, dependent: :destroy
  has_many :recipes, through: :consumer_recipes
  
  validates :name, uniqueness: true, presence: true
end 
