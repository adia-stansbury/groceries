require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

class GoogleCalendarGeneratedMealPlansController < ApplicationController
  def new
    adia_meal_plan = Consumer.find_by(name: 'Adia').meal_plans.create
    mick_meal_plan = Consumer.find_by(name: 'Mick').meal_plans.create

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

    adia_new_rows = adia_mealplan_info
    mick_new_rows = mick_mealplan_info

    adia_meal_plan_recipes = adia_meal_plan.meal_plan_recipes
    mick_meal_plan_recipes = mick_meal_plan.meal_plan_recipes

    adia_meal_plan_recipes.create(adia_new_rows)
    mick_meal_plan_recipes.create(mick_new_rows)

    redirect_to meal_plans_path
  end
end
