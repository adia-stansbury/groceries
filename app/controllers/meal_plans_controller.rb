class MealPlansController < ApplicationController
  CONSUMERS = ['Adia']

  def index
    @meal_plans = MealPlan.includes(:consumer, :meal_plan_recipes, :recipes).order(created_at: :desc).limit(8)

    render 'new' unless @meal_plans
  end

  def show
    @meal_plan = MealPlan.includes(:consumer, :meal_plan_recipes, :recipes)
      .find(params[:id])
  end

  def create

    CONSUMERS.each do |consumer|
      events_items = GoogleCalendarApi.events_items(
        ENV["#{consumer.upcase}_CALENDAR_ID"],
        params['start_date'].to_time.iso8601,
      )

      if events_items.present?
        meal_plan = create_meal_plan(consumer)
        create_meal_plan_recipes(events_items, meal_plan)

        redirect_to meal_plans_path
      else
        flash.alert = 'Calendar has no meal plan for date selected'
        render 'new'
      end
    end

  end

  private
    def create_meal_plan(name)
      Consumer.find_by(name: name).meal_plans.create!
    end

    def create_meal_plan_recipes(events_items, meal_plan)
      mealplan_info = MealPlan.info_from_calendar(events_items)

      meal_plan.meal_plan_recipes.create!(mealplan_info[:info_valid])

      invalid_mealplan_info_alert(mealplan_info)
    end

    def invalid_mealplan_info_alert(mealplan_info)
      recipe_names_not_in_db = mealplan_info[:recipe_names_not_in_db]
      if recipe_names_not_in_db.present?
        flash[:alert] = "These recipe names were not found: #{recipe_names_not_in_db}"
      end
    end
end
