require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'

class GoogleCalendarGeneratedMealPlansController < ApplicationController
  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
  APPLICATION_NAME = 'Google Calendar API Ruby Quickstart'
  CLIENT_SECRETS_PATH = 'config/client_secret.json'
  CREDENTIALS_PATH = File.join(Dir.home, '.credentials',
                              "calendar-ruby-quickstart.yaml")
  SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY

  def new
    # Ensure valid credentials, either by restoring from the saved credentials
    # files or intitiating an OAuth2 authorization. If authorization is required,
    # the user's default browser will be launched to approve the request.
    #
    # @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
    def authorize
      FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

      client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
      token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
      authorizer = Google::Auth::UserAuthorizer.new(
        client_id, SCOPE, token_store)
      user_id = 'default'
      credentials = authorizer.get_credentials(user_id)
      if credentials.nil?
        url = authorizer.get_authorization_url(
          base_url: OOB_URI)
        puts "Open the following URL in the browser and enter the " +
            "resulting code after authorization"
        puts url
        code = gets
        credentials = authorizer.get_and_store_credentials_from_code(
          user_id: user_id, code: code, base_url: OOB_URI)
      end
      credentials
    end

    def get_calendar_events(calendar_id) 
      #initialize api
      service = Google::Apis::CalendarV3::CalendarService.new
      service.client_options.application_name = APPLICATION_NAME
      service.authorization = authorize

      response = service.list_events(calendar_id,
                                    max_results: 106,
                                    single_events: true,
                                    order_by: 'startTime',
                                    time_min: (Time.now + (60 * 60 * 24)).iso8601
                                    )
    end 

    def create_meal_plan(consumer)
      consumer_id = Consumer.where(name: consumer).first.id
      MealPlan.create(consumer_id: consumer_id)
    end 

    adia_meal_plan = create_meal_plan('Adia')
    mick_meal_plan = create_meal_plan('Mick')

    def get_recipe_names_from_calendar(calendar_id)
      recipe_names = []
      get_calendar_events(calendar_id).items.each do | event |
        recipe_names << event.summary
      end 
      recipe_names
    end 

    def get_hash_of_meal_plan_recipe_info(calendar_id)
      meal_plan_recipe_info = []
      recipe_ids = []
      recipe_names = get_recipe_names_from_calendar(calendar_id)
      recipe_names.each do |recipe_name|
        recipe_ids << Recipe.where(name: recipe_name).first.id
      end 
      recipe_ids.each do |recipe_id|
      #Recipe.where({name: recipe_names}).pluck(:id).each do |recipe_id|
        #I had to get rid of this optimization b/c it was calling unique on
        #recipe names
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
