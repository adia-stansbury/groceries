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

    adia_mealplan_info_sans_dates = MealPlan.fetch_mealplan_info_sans_dates(adia_mealplan_info)
    mick_mealplan_info_sans_dates = MealPlan.fetch_mealplan_info_sans_dates(mick_mealplan_info)

    adia_new_rows = MealPlanRecipe.new_rows(
      MealPlan.add_recipe_ids_to_build(adia_mealplan_info_sans_dates)
    ) + MealPlanRecipe::ADIA_TEMPLATE

    mick_new_rows = MealPlanRecipe.new_rows(
      MealPlan.add_recipe_ids_to_build(mick_mealplan_info_sans_dates)
    ) + MealPlanRecipe::MICK_TEMPLATE

    adia_meal_plan_recipes = adia_meal_plan.meal_plan_recipes
    mick_meal_plan_recipes = mick_meal_plan.meal_plan_recipes

    adia_meal_plan_recipes.create(adia_new_rows)
    mick_meal_plan_recipes.create(mick_new_rows)

    adia_mealplan_dates = MealPlanRecipeDay.fetch_just_mealplan_dates(adia_mealplan_info)
    mick_mealplan_dates = MealPlanRecipeDay.fetch_just_mealplan_dates(mick_mealplan_info)

    adia_mealplan_recipe_ids_dates = MealPlan.add_recipe_ids_to_build(adia_mealplan_dates)
    mick_mealplan_recipe_ids_dates = MealPlan.add_recipe_ids_to_build(mick_mealplan_dates)

    adia_recipe_ids_dates = MealPlanRecipeDay.fetch_recipe_ids_date_hash(
      adia_mealplan_recipe_ids_dates
    )
    mick_recipe_ids_dates = MealPlanRecipeDay.fetch_recipe_ids_date_hash(
      mick_mealplan_recipe_ids_dates
    )

    adia_meal_plan_recipe_day_rows = MealPlanRecipeDay.build(
      adia_meal_plan_recipes,
      adia_recipe_ids_dates
    )
    mick_meal_plan_recipe_day_rows = MealPlanRecipeDay.build(
      mick_meal_plan_recipes,
      mick_recipe_ids_dates
    )

    MealPlanRecipeDay.create(adia_meal_plan_recipe_day_rows)
    MealPlanRecipeDay.create(mick_meal_plan_recipe_day_rows)

    redirect_to meal_plans_path
  end
end
