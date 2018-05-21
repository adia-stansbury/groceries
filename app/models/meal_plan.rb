class MealPlan < ActiveRecord::Base
  has_many :meal_plan_recipes, dependent: :destroy
  has_many :recipes, through: :meal_plan_recipes
  belongs_to :consumer

  validates :consumer, presence: true

  def self.info_from_calendar(events_items)
    info = { info_valid: [], recipe_names_not_in_db: [] }
    events_items.each do |event|
      recipe_date = event.start.date.to_date
      recipe_name = event.summary.strip.titleize
      recipe = Recipe.find_by(name: recipe_name)
      if recipe
        info[:info_valid] << {
          recipe_id: recipe.id,
          date: recipe_date
        }
      else
        info[:recipe_names_not_in_db] << recipe_name
      end
    end
    info
  end

  def nutrition
    Nutrition::MealPlanQuery.new(self).nutrition
  end

  def daily_nutrition(date)
    Nutrition::DailyMealPlanQuery.new(self, date).nutrition
  end

  def dates
    meal_plan_recipes.order(:date).distinct.pluck(:date)
  end

  def recipes_for_date(date)
    meal_plan_recipes.includes(:recipe).where(date: date).order('recipes.name')
  end
end
