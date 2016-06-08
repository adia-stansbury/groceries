class MealPlansController < ApplicationController
  def new 
    @consumers = Consumer.all.order(:name)
    @recipes = Recipe.all.order(:name)
    @meal_plan = MealPlan.new
    2.times { @meal_plan.meal_plan_recipes.build }
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
      :consumer_id,
      meal_plan_recipes_attributes: [:id, { recipe_id: [] }] 
    )
  end 
end 
