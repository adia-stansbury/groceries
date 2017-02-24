require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

class GoogleCalendarGeneratedMealPlansController < ApplicationController
  def new
    adia_meal_plan = Consumer.find_by(name: 'Adia').meal_plans.create
    mick_meal_plan = Consumer.find_by(name: 'Mick').meal_plans.create

    adia_mealplan = GoogleCalendarApi.get_mealplan_from_calendar(ENV['ADIA_CALENDAR_ID'], params['start_date'].to_time.iso8601)
    mick_mealplan = GoogleCalendarApi.get_mealplan_from_calendar(ENV['MICK_CALENDAR_ID'], params['start_date'].to_time.iso8601)

    adia_new_rows = MealPlanRecipe.new_rows(
      MealPlanRecipe.fetch_recipe_ids_with_flag(adia_mealplan)
    ) + MealPlanRecipe::ADIA_TEMPLATE
    mick_new_rows = MealPlanRecipe.new_rows(
      MealPlanRecipe.fetch_recipe_ids_with_flag(mick_mealplan)
    ) + MealPlanRecipe::MICK_TEMPLATE

    adia_meal_plan.meal_plan_recipes.create(adia_new_rows)
    mick_meal_plan.meal_plan_recipes.create(mick_new_rows)

    redirect_to meal_plans_path
  end
end
