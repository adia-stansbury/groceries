class MealPlansController < ApplicationController
  def index
    @meal_plans = MealPlan.all.order(created_at: :desc)
  end 

  def show
    @meal_plan = MealPlan.find(params[:id])
    recipe_ids_array = @meal_plan.recipes.pluck(:id)
    formatted_recipe_ids = recipe_ids_array * ","
    @aggregate_nutrient_intake = MealPlan.nutrient_intake(formatted_recipe_ids)      
    @groups = NutrientGroup.all.order(:name)
  end 
  
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
    
    if @meal_plan.save
      render 'index'
    end 
  end 

  private
  def meal_plan_params
    params.require(:meal_plan).permit(:id, :consumer_id, recipe_ids: [])
  end 
end 
