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
                                    max_results: 16,
                                    single_events: true,
                                    order_by: 'startTime',
                                    time_min: Time.now.iso8601)
    end 

    adia_meal_plan = MealPlan.create(consumer_id: 1)
    mick_meal_plan = MealPlan.create(consumer_id: 4)

    lunches = get_calendar_events(ENV['LUNCH_CALENDAR_ID'])
    dinners = get_calendar_events(ENV['DINNER_CALENDAR_ID'])

    lunch_calendar_recipes = []
    lunches.items.each do |recipe|
      recipe_id = Recipe.where(name: recipe.summary).first.id
      lunch_calendar_recipes << { meal_plan_id: adia_meal_plan.id, recipe_id: recipe_id, number_of_recipes: 1}
    end 

    template_recipes = [
      { # yogurts
        meal_plan_id: adia_meal_plan.id,
        recipe_id: 7, 
        number_of_recipes: 1
      },
      { 
        meal_plan_id: mick_meal_plan.id,
        recipe_id: 13, 
        number_of_recipes: 1
      },
      {
        # 3 apples
        meal_plan_id: mick_meal_plan.id,
        recipe_id: 44, 
        number_of_recipes: 1
      },
      {
        meal_plan_id: mick_meal_plan.id,
        recipe_id: 44, 
        number_of_recipes: 1
      },
      {
        meal_plan_id: mick_meal_plan.id,
        recipe_id: 44, 
        number_of_recipes: 1
      },
      {
        # 3 carbonated waters
        meal_plan_id: mick_meal_plan.id,
        recipe_id: 21, 
        number_of_recipes: 1
      },
      {
        meal_plan_id: mick_meal_plan.id,
        recipe_id: 21, 
        number_of_recipes: 1
      },
      {
        meal_plan_id: mick_meal_plan.id,
        recipe_id: 21, 
        number_of_recipes: 1
      }
    ]

    records_to_create = lunch_calendar_recipes + template_recipes 

    MealPlanRecipe.create(records_to_create)

    redirect_to meal_plans_path
  end 
end 
