class MealPlanRecipe < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :meal_plan

  ADIA_TEMPLATE = [
    # yogurts
    {
      recipe_id: 7,
      number_of_recipes: 1
    },
    # hot chocolate
    {
      recipe_id: 52,
      number_of_recipes: 1
    }
  ]

  MICK_TEMPLATE = [
    #yogurts
    {
      recipe_id: 13,
      number_of_recipes: 1
    },
    # hot chocolate
    {
      recipe_id: 52,
      number_of_recipes: 1
    },
    # 3 apples
    {
      recipe_id: 44,
      number_of_recipes: 1
    },
    {
      recipe_id: 44,
      number_of_recipes: 1
    },
    {
      recipe_id: 44,
      number_of_recipes: 1
    },
    # 3 carbonated waters
    {
      recipe_id: 21,
      number_of_recipes: 1
    },
    {
      recipe_id: 21,
      number_of_recipes: 1
    },
    {
      recipe_id: 21,
      number_of_recipes: 1
    }
  ]

  # Recipe.where({name: recipe_names}).pluck(:id).each do |recipe_id|
    # I had to get rid of this optimization b/c it was calling unique on
    #  recipe names
  def self.new_rows(recipe_names)
    meal_plan_recipe_rows = []
    recipe_ids = []
    recipe_names.each do |recipe_name|
      recipe_ids << Recipe.where(name: recipe_name).first.id
    end
    recipe_ids.each do |recipe_id|
      meal_plan_recipe_rows << {
        recipe_id: recipe_id,
        number_of_recipes: 1
      }
    end
    meal_plan_recipe_rows
  end
end
