class GroceryListsController < ApplicationController
  def new
    sql_meal_plan_ids = SqlFormatter.sql_ids(params['meal_plan_ids'])
    shopping_list = MealPlan.shopping_list(sql_meal_plan_ids)
    first_day_recipes = MealPlanRecipe.fetch_first_day_recipe_names(
      params['meal_plan_ids']
    )

    EvernoteApi.create_note(shopping_list, first_day_recipes)
  end
end
