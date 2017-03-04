class MealPlanRecipe < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :meal_plan

  validates :recipe_id, uniqueness: { scope: :meal_plan_id, message: 'This mealplan already has this recipe. Instead of creating another record for this same recipe, edit the existing recipe for this mealplan'}
  validates :recipe_id, :meal_plan_id, :number_of_recipes, presence: true
  validates :first_day_recipe, inclusion: { in: [true, false] }
  validates :first_day_recipe, exclusion: { in: [nil] }

  ADIA_TEMPLATE = [
    # yogurts
    { recipe_id: 7, number_of_recipes: 1 },
    # fried eggs
    { recipe_id: 80, number_of_recipes: 2, first_day_recipe: true },
    # hot chocolate
    { recipe_id: 52, number_of_recipes: 1 },
    # grapefruits
    { recipe_id: 45, number_of_recipes: 8, first_day_recipe: true },
    # roasted veggies
    { recipe_id: 69, number_of_recipes: 2, first_day_recipe: true },
  ]

  MICK_TEMPLATE = [
    # yogurts
    { recipe_id: 13, number_of_recipes: 1 },
    # hot chocolate
    { recipe_id: 52, number_of_recipes: 1 },
    # apples
    { recipe_id: 44, number_of_recipes: 3 },
    # carbonated waters
    { recipe_id: 21, number_of_recipes: 3 },
  ]

  def self.add_recipe_ids_to_mealplan(mealplan)
    mealplan.keys.map do |key|
      mealplan[key][:recipe_id] = Recipe.where(name: key).first.id
    end
    mealplan
  end

  def self.fetch_first_day_recipe_names(mealplan_ids)
    self.eager_load(:recipe).where(
      meal_plan_id: mealplan_ids, first_day_recipe: true
    ).pluck(:name)
  end

  def self.new_rows(mealplan_with_recipe_ids)
    meal_plan_recipe_rows = []
    mealplan_with_recipe_ids.each do |_, value|
      meal_plan_recipe_rows << value
    end
    meal_plan_recipe_rows
  end
end
