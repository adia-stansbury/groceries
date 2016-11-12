class Food < ActiveRecord::Base
  has_many :food_nutrients, dependent: :destroy
  has_many :nutrients, through: :food_nutrients

  validates :name, presence: true, uniqueness: true

  def self.nutrition(meal_plan_recipe_names, food_name)
    if meal_plan_recipe_names.include?(food_name)
      food_nutrients = Food.where(name: food_name).first.nutrients.pluck(
        :name,
        :nutrient_amount
      ).to_h 
    else 
      food_nutrients = {}
    end 
  end 

  def nutrition
    nutrients.pluck(:name, :nutrient_amount).to_h 
  end 
end  
