class MealPlansController < ApplicationController
  def new 
    @consumers = Consumer.all.order(:name)
    @recipes = Recipe.all.order(:name)
    @meal_plan = MealPlan.new
  end 

  def create
    @meal_plan = MealPlan.new(meal_plan_params),
    
    if @meal_plan.save
      redirect_to '/'
    else
      render 'new'
    end 
  end 

  private
  def meal_plan_params
    params.require(:meal_plan).permit(
      :consumer_id 
    )
  end 
end 
