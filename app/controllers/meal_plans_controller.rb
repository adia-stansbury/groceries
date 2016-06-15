class MealPlansController < ApplicationController
  def new 
    @consumers = Consumer.all.order(:name)
    @recipes = Recipe.all.order(:name)
    @meal_plan = MealPlan.new
  end 

  def create
    @meal_plan = MealPlan.create(consumer_id: params['meal_plan']['consumer_id'])     
    params['meal_plan']['recipe_ids'].each do |recipe_id|
      if recipe_id != ''
        @meal_plan_recipe = MealPlanRecipe.create(
          recipe_id: recipe_id, 
          meal_plan_id: @meal_plan.id
        ) 
      end 
    end 
    
    render 'index'
  end 

  private
  def meal_plan_params
    params.require(:meal_plan).permit(:consumer_id, recipe_ids: [])
  end 
end 
