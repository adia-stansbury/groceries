class MealPlanRecipesController < ApplicationController
  def create
    @recipes = Recipe.all.order(:name)
    @meal_plan = MealPlan.find(params[:meal_plan_id])
    params[:meal_plan_recipe][:number_of_recipes].to_i.times do
      @meal_plan.meal_plan_recipes.create(
        recipe_id: params[:meal_plan_recipe][:recipe_id],
        number_of_recipes: 1
      )
    end 
    redirect_to meal_plan_path(@meal_plan)
  end 

  private
  
  def meal_plan_recipe_params
    params.require(:meal_plan_recipe).permit(:number_of_recipes, :recipe_id)
  end 
end 

