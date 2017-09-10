class MealPlanDaysController < ApplicationController
  # TODO either move this method to mealplanrecipe controller, or have it
  # namespaced to mealplan
  def show
    @meal_plan = MealPlan.includes(:consumer, :meal_plan_recipes, :recipes).
      find(params[:meal_plan_id])
    @consumer = @meal_plan.consumer
    @date = params[:id].to_date
    @meal_plan_recipes = @meal_plan.meal_plan_recipes.includes(:recipe)
      .where(date: @date).order('recipes.name')
    @recipes = Recipe.order(:name)
    @groups = NutrientGroup.includes(:nutrients).order(:name)
    @mealsquare = Food.find_by(name: 'Mealsquare')
    @soylent = Food.find_by(name: 'Soylent')
    @nutrients_upper_limit = Nutrient.upper_limit_hash
    @consumer_rdas = @consumer.rda_hash
    @aggregate_nutrient_intake = @meal_plan.nutrient_intake(@date, @date)
  end
end
