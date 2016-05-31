class MealPlanRecipesController < ApplicationController
  def new 
    @recipes = Recipe.all.order(:name) 
    @consumers = Consumer.all.order(:name)
    @meal_plan_recipe = MealPlanRecipe.new()
  end 

  def create
    @meal_plan_recipe = MealPlanRecipe.new(meal_plan_recipe_params)
    binding.pry
    mealplan = MealPlan.create(consumer_id: params[:consumer_id])
    @meal_plan_recipe.meal_plan_id = mealplan.id
    
    if @meal_plan_recipe.save
      render 'new'
    else
      render 'new'
    end 
  end 

  private
  def meal_plan_recipe_params
    params.require(:meal_plan_recipe).permit(:consumer_id, :recipe_id)
  end 
end 


