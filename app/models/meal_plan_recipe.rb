class MealPlanRecipe < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :meal_plan

  validates :recipe_id, :meal_plan_id, :date, presence: true
  validates :first_day_recipe, inclusion: { in: [true, false] }
  validates :first_day_recipe, exclusion: { in: [nil] }

  scope :for_date, ->(date) { where(date: date) }

  def self.is_first_day_recipe(recipe_date, start_date)
    recipe_date == start_date.to_date
  end

  def self.fetch_first_day_recipe_names(mealplan_ids)
    self.eager_load(:recipe).where(
      meal_plan_id: mealplan_ids, first_day_recipe: true
    ).pluck(:name)
  end
end
