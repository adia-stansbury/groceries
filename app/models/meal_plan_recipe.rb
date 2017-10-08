class MealPlanRecipe < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :meal_plan

  validates :recipe_id, :meal_plan_id, :date, presence: true
  validates :first_day_recipe, inclusion: { in: [true, false] }
  validates :first_day_recipe, exclusion: { in: [nil] }

  def self.is_first_day_recipe(recipe_date, start_date)
    recipe_date == start_date.to_date
  end

  def self.fetch_first_day_recipe_names(mealplan_ids)
    self.eager_load(:recipe).where(
      meal_plan_id: mealplan_ids, first_day_recipe: true
    ).pluck(:name)
  end

  def self.new_records(info, dictionary_name_id)
    new_records = []
    info.each do | row |
      recipe_name = row[:recipe_name]
      swap_name_for_id = { recipe_id: dictionary_name_id[recipe_name] }
      unchanged_info = row.select { | key, _ | key != :recipe_name }
      new_records << swap_name_for_id.merge(unchanged_info)
    end

    new_records
  end
end
