class Recipe < ActiveRecord::Base
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  before_save :capitalize_recipe_name!

  validates :name, uniqueness: true, presence: true

  private

  def capitalize_recipe_name!
    word_array = self.name.split.each { |word| word.capitalize! }
    self.name = word_array.join(' ')
  end 
end
