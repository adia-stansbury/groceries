class MealPlanRecipesController < ApplicationController
  def create
    @meal_plan = MealPlan.find(params[:meal_plan_id])
    @meal_plan_recipe = @meal_plan.meal_plan_recipes.create
    @meal_plan_recipe.recipe_id = params[:recipe_id].first.to_i
    @meal_plan_recipe.save
    redirect_to meal_plan_path(@meal_plan)
  end 

  private
end 

