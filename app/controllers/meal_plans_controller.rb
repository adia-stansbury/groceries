class MealPlansController < ApplicationController
  def index
    @meal_plans = MealPlan.all.order(created_at: :desc)
  end 

  def show
    @meal_plan = MealPlan.find(params[:id])
    @recipes = Recipe.all.order(:name)
    @consumer = @meal_plan.consumer.name 
    @week = @meal_plan.created_at
    if @meal_plan.recipes.present?
      recipe_ids_array = @meal_plan.recipes.pluck(:id)
      formatted_recipe_ids = recipe_ids_array * ","
      @aggregate_nutrient_intake = MealPlan.nutrient_intake(formatted_recipe_ids)      
      @groups = NutrientGroup.all.order(:name)
    end 
  end 
  
  def new 
    @consumers = Consumer.all.order(:name)
    @recipes = Recipe.all.order(:name)
    @meal_plan = MealPlan.new
  end 

  def create
    @meal_plan = MealPlan.new(meal_plan_params)     
    @recipes = Recipe.all.order(:name)
    
    if @meal_plan.save
      render 'show'
    else
      render 'new'
    end 
  end 

  private
  def meal_plan_params
    params.require(:meal_plan).permit(:consumer_id)
  end 
end 
