class MealPlansController < ApplicationController
  def index
    @meal_plans = MealPlan.order(created_at: :desc).limit(2)
  end

  def show
    @meal_plan = MealPlan.find(params[:id])
    @recipes = Recipe.order(:name)
    @consumer = @meal_plan.consumer
    @week = @meal_plan.created_at
    if @meal_plan.recipes.present?
      meal_plan_recipe_ids = @meal_plan.recipes.pluck('recipes.id')
      @recipes = Recipe.where.not(id: meal_plan_recipe_ids).order(:name)
      @aggregate_nutrient_intake = @meal_plan.nutrient_intake(
        @meal_plan.dates.first,
        @meal_plan.dates.last
      )

      @groups = NutrientGroup.order(:name)
      @mealsquare = Food.find_by(name: 'Mealsquare')
      @soylent = Food.find_by(name: 'Soylent')
      @nutrients_upper_limit = Nutrient.upper_limit_hash
      @consumer_rdas = @consumer.rda_hash
    end
  end

  def new
    @consumers = Consumer.order(:name)
    @recipes = Recipe.order(:name)
    @meal_plan = MealPlan.new
    @consumer = Consumer.new
    if params[:consumer].present?
      @consumer = Consumer.new(consumer_params)
      @consumer.save
      render 'new'
    end
  end

  def create
    @meal_plan = MealPlan.new(meal_plan_params)
    @recipes = Recipe.order(:name)

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

  def consumer_params
    params.require(:consumer).permit(:name)
  end
end
