class Nutrient < ActiveRecord::Base
  has_many :ingredient_nutrients, dependent: :destroy
  has_many :ingredients, through: :ingredient_nutrients
  has_many :consumer_nutrients, dependent: :destroy
  has_many :food_nutrients, dependent: :destroy
  has_many :foods, through: :food_nutrients
  belongs_to :nutrient_group
  belongs_to :unit

  validates :name, uniqueness: true, presence: true

  before_save :remove_extraneous_characters

  def self.fetch_id_from_name(name)
    self.where(name: name).first.id
  end 

  def weekly_upper_limit
    self.upper_limit.present? ? (self.upper_limit * 7) : ''  
  end 
  
  private

  def remove_extraneous_characters
    name.chomp!
    name.strip!
  end 
end 
