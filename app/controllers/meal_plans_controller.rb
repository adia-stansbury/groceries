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
    start_datetime = params['start_date'].to_time.iso8601
    start_date = start_datetime.to_date

    ['Adia', 'Mick'].each do |consumer|
      meal_plan = create_meal_plan(consumer)

      # TODO: keep ENV?
      events_items = GoogleCalendarApi.events_items(
        ENV["#{consumer.upcase}_CALENDAR_ID"],
        start_datetime,
      )

      create_meal_plan_recipes(events_items, start_date, meal_plan)
    end

    redirect_to meal_plans_path
  end

  private
    def create_meal_plan(name)
      Consumer.find_by(name: name).meal_plans.create!
    end

    def create_meal_plan_recipes(events_items, start_date, meal_plan)
      if events_items
        mealplan_info = MealPlan.info_from_calendar(
          events_items,
          start_date
        )
        recipe_names = MealPlan.recipe_names(mealplan_info)
        missing_recipe_names = Recipe.recipes_to_create(recipe_names)
        if missing_recipe_names.present?
          flash[:alert] = "These newly created recipes need their ingredients added: #{missing_recipe_names}"
        end
        Recipe.create_missing_recipes(missing_recipe_names)
        dictionary_name_id = Recipe.dictionary_name_id(recipe_names)
        new_records = MealPlanRecipe.new_records(mealplan_info, dictionary_name_id)

        meal_plan.meal_plan_recipes.create!(new_records)
      end
    end
end
