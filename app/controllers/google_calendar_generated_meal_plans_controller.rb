require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require "#{Rails.root}/lib/google_calendar_api"

class GoogleCalendarGeneratedMealPlansController < ApplicationController
  def new
    def create_meal_plan(consumer)
      Consumer.where(name: consumer).first.meal_plans.create()      
    end 

    adia_meal_plan = create_meal_plan('Adia')
    mick_meal_plan = create_meal_plan('Mick')

    def get_recipe_names_from_calendar(calendar_id)
      recipe_names = []
      GoogleCalendarApi.get_calendar_events(calendar_id).items.each do | event |
        recipe_names << event.summary
      end 
      recipe_names
    end 

    def get_hash_of_meal_plan_recipe_info(calendar_id)
      #Recipe.where({name: recipe_names}).pluck(:id).each do |recipe_id|
        #I had to get rid of this optimization b/c it was calling unique on
        #recipe names
      meal_plan_recipe_info = []
      recipe_ids = []
      recipe_names = get_recipe_names_from_calendar(calendar_id)
      recipe_names.each do |recipe_name|
        recipe_ids << Recipe.where(name: recipe_name).first.id
      end 
      recipe_ids.each do |recipe_id|
        meal_plan_recipe_info << { 
          recipe_id: recipe_id, 
          number_of_recipes: 1
        }
      end 
      meal_plan_recipe_info
    end 

    adia_template_recipes = [
      { # yogurts
        meal_plan_id: adia_meal_plan.id,
        recipe_id: 7, 
        number_of_recipes: 1
      }
    ]

    mick_template_recipes = [
      { #yogurts 
        recipe_id: 13, 
        number_of_recipes: 1
      },
      {
        # 3 apples
        recipe_id: 44, 
        number_of_recipes: 1
      },
      {
        recipe_id: 44, 
        number_of_recipes: 1
      },
      {
        recipe_id: 44, 
        number_of_recipes: 1
      },
      {
        # 3 carbonated waters
        recipe_id: 21, 
        number_of_recipes: 1
      },
      {
        recipe_id: 21, 
        number_of_recipes: 1
      },
      {
        recipe_id: 21, 
        number_of_recipes: 1
      }
    ]

    adia_records_to_create = get_hash_of_meal_plan_recipe_info(ENV['ADIA_CALENDAR_ID']) + 
      adia_template_recipes 
    mick_records_to_create = get_hash_of_meal_plan_recipe_info(ENV['MICK_CALENDAR_ID']) + 
      mick_template_recipes

    adia_meal_plan.meal_plan_recipes.create(adia_records_to_create)
    mick_meal_plan.meal_plan_recipes.create(mick_records_to_create)

    redirect_to meal_plans_path
  end 
end 
