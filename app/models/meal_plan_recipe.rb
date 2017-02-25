class MealPlanRecipe < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :meal_plan

  # number_of_recipes attribute is dead code at the moment.
  ADIA_TEMPLATE = [
    # yogurts
    { recipe_id: 7, number_of_recipes: 1 },
    # fried eggs
    { recipe_id: 80, number_of_recipes: 1, first_day_recipe: true },
    { recipe_id: 80, number_of_recipes: 1 },
    # hot chocolate
    { recipe_id: 52, number_of_recipes: 1 },
    # grapefruits
    { recipe_id: 45, number_of_recipes: 1, first_day_recipe: true },
    { recipe_id: 45, number_of_recipes: 1 },
    { recipe_id: 45, number_of_recipes: 1 },
    { recipe_id: 45, number_of_recipes: 1 },
    { recipe_id: 45, number_of_recipes: 1 },
    { recipe_id: 45, number_of_recipes: 1 },
    { recipe_id: 45, number_of_recipes: 1 },
    { recipe_id: 45, number_of_recipes: 1 },
    # roasted veggies
    { recipe_id: 69, number_of_recipes: 1, first_day_recipe: true },
    { recipe_id: 69, number_of_recipes: 1 },
  ]

  MICK_TEMPLATE = [
    #yogurts
    { recipe_id: 13, number_of_recipes: 1 },
    # hot chocolate
    { recipe_id: 52, number_of_recipes: 1 },
    # 3 apples
    { recipe_id: 44, number_of_recipes: 1 },
    { recipe_id: 44, number_of_recipes: 1 },
    { recipe_id: 44, number_of_recipes: 1 },
    # 3 carbonated waters
    { recipe_id: 21, number_of_recipes: 1 },
    { recipe_id: 21, number_of_recipes: 1 },
    { recipe_id: 21, number_of_recipes: 1 }
  ]

  def self.fetch_recipe_ids_with_flag(mealplan)
    recipe_ids_with_flag = []
    mealplan.each do |row|
      recipe_ids_with_flag << {
        recipe_id: Recipe.where(name: row[:recipe_name]).first.id,
        first_day_recipe: row[:first_day_recipe]
      }
    end
    recipe_ids_with_flag
  end

  def self.fetch_first_day_recipe_names(mealplan_ids)
    self.eager_load(:recipe).where(
      meal_plan_id: mealplan_ids, first_day_recipe: true
    ).pluck(:name)
  end

  # Recipe.where({name: recipe_names}).pluck(:id).each do |recipe_id|
    # I had to get rid of this optimization b/c it was calling unique on
    #  recipe names
  def self.new_rows(recipe_ids_with_flag)
    meal_plan_recipe_rows = []
    recipe_ids_with_flag.each do |row|
      meal_plan_recipe_rows << {
        recipe_id: row[:recipe_id],
        number_of_recipes: 1,
        first_day_recipe: row[:first_day_recipe]
      }
    end
    meal_plan_recipe_rows
  end
end
