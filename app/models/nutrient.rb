class Nutrient < ActiveRecord::Base
  has_many :ingredient_nutrients, dependent: :destroy
  has_many :ingredients, through: :ingredient_nutrients
  has_many :consumer_nutrients, dependent: :destroy
  belongs_to :nutrient_group
  belongs_to :unit

  validates :name, uniqueness: true, presence: true

  before_save :remove_extraneous_characters
  
  private

  def remove_extraneous_characters
    name.chomp!
    name.strip!
  end 
end 
