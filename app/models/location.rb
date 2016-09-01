class Location < ActiveRecord::Base
  has_many :ingredients
  has_many :recipe_ingredients, through: :ingredients, dependent: :destroy

  validates :name, uniqueness: true, presence: true

  before_save :remove_extraneous_characters
  
  private

  def remove_extraneous_characters
    name.chomp!
    name.strip!
  end 
end 
