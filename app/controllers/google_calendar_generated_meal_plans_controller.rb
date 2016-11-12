require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

class GoogleCalendarGeneratedMealPlansController < ApplicationController
  def new
    adia_meal_plan = Consumer.find_by(name: 'Adia').meal_plans.create
    mick_meal_plan = Consumer.find_by(name: 'Mick').meal_plans.create

    adia_recipe_names = GoogleCalendarApi.get_recipe_names_from_calendar(ENV['ADIA_CALENDAR_ID'])
    mick_recipe_names = GoogleCalendarApi.get_recipe_names_from_calendar(ENV['MICK_CALENDAR_ID'])

    adia_new_rows = MealPlanRecipe.new_rows(adia_recipe_names) + 
      MealPlanRecipe::ADIA_TEMPLATE
    mick_new_rows = MealPlanRecipe.new_rows(mick_recipe_names) + 
      MealPlanRecipe::MICK_TEMPLATE

    adia_meal_plan.meal_plan_recipes.create(adia_new_rows)
    mick_meal_plan.meal_plan_recipes.create(mick_new_rows)

    redirect_to meal_plans_path
  end 
end 
