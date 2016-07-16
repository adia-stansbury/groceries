class MealPlanRecipesController < ApplicationController
  def create
    @recipes = Recipe.all.order(:name)
    @meal_plan = MealPlan.find(params[:meal_plan_id])
    @meal_plan_recipe = @meal_plan.meal_plan_recipes.create(meal_plan_recipe_params)
    redirect_to meal_plan_path(@meal_plan)
  end 

  private
  
  def meal_plan_recipe_params
    params.require(:meal_plan_recipe).permit(:number_of_recipes, :recipe_id)
  end 
end 

