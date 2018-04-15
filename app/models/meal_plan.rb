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

  def dates
    meal_plan_recipes.order(:date).distinct.pluck(:date)
  end

  def recipes_for_date(date)
    meal_plan_recipes.includes(:recipe).where(date: date).order('recipes.name')
  end

  def nutrition(start_date, end_date)
    IngredientNutrient
    .select(
      'nutrients.id',
      'nutrients.name',
      'ingredient_nutrients.unit AS amt_consumed_unit',
      'sum((value/100)*amount_in_grams) AS amt_consumed'
    )
    .joins(:nutrient, recipe_ingredient: :meal_plan_recipe)
    .where(
      "meal_plan_recipes.meal_plan_id = (#{id})
      AND meal_plan_recipes.date
      BETWEEN CAST('#{start_date}' AS date) AND CAST('#{end_date}' AS date)"
    )
    .group('nutrients.id', 'nutrients.name', 'amt_consumed_unit')
    .order('nutrients.name')
  end
end
