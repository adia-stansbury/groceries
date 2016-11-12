class Food < ActiveRecord::Base
  has_many :food_nutrients, dependent: :destroy
  has_many :nutrients, through: :food_nutrients

  validates :name, presence: true, uniqueness: true

  def nutrition
    nutrients.pluck(:name, :nutrient_amount).to_h 
  end 
end  
