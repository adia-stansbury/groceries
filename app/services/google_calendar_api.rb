module GoogleCalendarApi
  OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
  APPLICATION_NAME = 'Google Calendar API Ruby Quickstart'
  CLIENT_SECRETS_PATH = 'config/client_secret.json'
  CREDENTIALS_PATH = File.join(Dir.home, '.credentials',
                              "calendar-ruby-quickstart.yaml")
  SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY

  # Ensure valid credentials, either by restoring from the saved credentials
  # files or intitiating an OAuth2 authorization. If authorization is required,
  # the user's default browser will be launched to approve the request.
  #
  # @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials

  def self.get_mealplan_from_calendar(calendar_id, start_date)
    mealplan = {}
    get_calendar_events(calendar_id, start_date).items.each do | event |
      event.start.date.to_date == start_date.to_date ? flag = true : flag = false
      if mealplan.has_key?(event.summary)
        mealplan[event.summary][:number_of_recipes] += 1
      else
        mealplan[event.summary] = {}
        mealplan[event.summary][:first_day_recipe] = flag
        mealplan[event.summary][:number_of_recipes] = 1
      end
    end
    mealplan
  end

  private

  def self.authorize
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

  def self.get_calendar_events(calendar_id, start_date)
    #initialize api
    service = Google::Apis::CalendarV3::CalendarService.new
    service.client_options.application_name = APPLICATION_NAME
    service.authorization = authorize

    service.list_events(
      calendar_id,
      max_results: 106,
      single_events: true,
      order_by: 'startTime',
      time_min: start_date
    )
  end
end
