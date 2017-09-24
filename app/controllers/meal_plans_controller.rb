class MealPlansController < ApplicationController
  def index
    @meal_plans = MealPlan.includes(:consumer, :meal_plan_recipes, :recipes).order(created_at: :desc).limit(8)

    render 'new' unless @meal_plans
  end

  def show
    @meal_plan = MealPlan.includes(:consumer, :meal_plan_recipes, :recipes).
      find(params[:id])
    @consumer = @meal_plan.consumer
    @week = @meal_plan.dates.first
    if @meal_plan.meal_plan_recipes
      @aggregate_nutrient_intake = @meal_plan.nutrient_intake(
        @meal_plan.dates.first,
        @meal_plan.dates.last
      )

      @groups = NutrientGroup.includes(:nutrients).order(:name)
      @mealsquare = Food.find_by(name: 'Mealsquare')
      @soylent = Food.find_by(name: 'Soylent')
      @nutrients_upper_limit = Nutrient.upper_limit_hash
      @consumer_rdas = @consumer.rda_hash
    end
  end

  def create
    start_date = params['start_date'].to_time.iso8601

    ['Adia', 'Mick'].each do |consumer|
      meal_plan = create_meal_plan(consumer)

      # TODO: keep ENV?
      calendar_events_items = GoogleCalendarApi.get_calendar_events_items(
        ENV["#{consumer.upcase}_CALENDAR_ID"],
        start_date
      )

      create_meal_plan_recipes(calendar_events_items, start_date, meal_plan)
    end

    redirect_to meal_plans_path
  end

  private
    def create_meal_plan(name)
      Consumer.find_by(name: name).meal_plans.create!
    end

    def create_meal_plan_recipes(calendar_events_items, start_date, meal_plan)
      if calendar_events_items
        mealplan_info = MealPlan.fetch_info_from_calendar(
          calendar_events_items,
          start_date
        )

        meal_plan.meal_plan_recipes.create!(mealplan_info)
      end
    end
end
