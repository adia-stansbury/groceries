# TODO: namespace to MealPlan
class MealPlanRecipesController < ApplicationController
  def create
    @recipes = Recipe.order(:name)
    @meal_plan = MealPlan.find(params[:meal_plan_id])
    @meal_plan.meal_plan_recipes.create!(
      recipe_id: params[:meal_plan_recipe][:recipe_id],
      date: params[:meal_plan_recipe][:date],
      first_day_recipe: params[:meal_plan_recipe][:first_day_recipe]
    )

    redirect_to meal_plan_path(@meal_plan)
  end

  def destroy
    meal_plan_recipe = MealPlanRecipe.includes(:meal_plan).find(params[:id])
    meal_plan = meal_plan_recipe.meal_plan
    meal_plan_recipe.destroy

    redirect_to meal_plan_path(meal_plan)
  end

  private

  def meal_plan_recipe_params
    params.require(:meal_plan_recipe).permit(
      :first_day_recipe,
      :meal_plan_id,
      :date,
      :recipe_id,
    )
  end
end

