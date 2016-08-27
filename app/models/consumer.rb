class Consumer < ActiveRecord::Base
  has_many :consumer_recipes, dependent: :destroy
  has_many :recipes, through: :consumer_recipes
  has_many :meal_plans, dependent: :destroy
  
  validates :name, uniqueness: true, presence: true

  before_save :remove_extraneous_characters
  
  private

  def remove_extraneous_characters
    name.chomp!
    name.strip!
  end 
end 
