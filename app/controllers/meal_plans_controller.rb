class MealPlansController < ApplicationController
  def index
    @meal_plans = MealPlan.order(created_at: :desc).limit(2)

    render 'new' unless @meal_plans
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

  def create
    start_date = params['start_date'].to_time.iso8601

    adia_calendar_events_items = GoogleCalendarApi.get_calendar_events_items(
      ENV['ADIA_CALENDAR_ID'],
      start_date
    )
    mick_calendar_events_items = GoogleCalendarApi.get_calendar_events_items(
      ENV['MICK_CALENDAR_ID'],
      start_date
    )

    adia_mealplan_info = MealPlan.fetch_info_from_calendar(
      adia_calendar_events_items,
      start_date
    )
    mick_mealplan_info = MealPlan.fetch_info_from_calendar(
      mick_calendar_events_items,
     start_date
    )

    mick_meal_plan = Consumer.find_by(name: 'Mick').meal_plans.create
    adia_meal_plan = Consumer.find_by(name: 'Adia').meal_plans.create

    adia_meal_plan.meal_plan_recipes.create(adia_mealplan_info)
    mick_meal_plan.meal_plan_recipes.create(mick_mealplan_info)

    @meal_plans = [adia_meal_plan, mick_meal_plan]

    render 'index'
  end
end
