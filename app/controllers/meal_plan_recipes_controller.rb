class MealPlanRecipesController < ApplicationController
  def new 
  end 

  def create
    @meal_plan_recipe = MealPlanRecipe.new(meal_plan_recipe_params)
    #first_or_initialize MealPlan
    mealplan = MealPlan.create(consumer_id: params[:consumer_id])
    @meal_plan_recipe.meal_plan_id = mealplan.id
    
    if @meal_plan_recipe.save
      redirect_to '/'
    else
      render 'new'
    end 
  end 

  private
  def meal_plan_recipe_params
    params.require(:meal_plan_recipe).permit(:recipe_id)
  end 
end 


