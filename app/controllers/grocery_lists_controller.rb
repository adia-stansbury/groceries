class GroceryListsController < ApplicationController
  def new
    note_title = EvernoteApi::NOTE_TITLE  
    note_notebook = EvernoteApi::NOTE_NOTEBOOK 
    auth_token = ENV['PROD_AUTH_TOKEN']
    evernote_host = EvernoteApi::EVERNOTE_HOST
    # auth_token = ENV['SANDBOX_AUTH_TOKEN']

    sql_meal_plan_ids = SqlFormatter.sql_ids(params['meal_plan_ids'])
    shopping_list = MealPlan.shopping_list(sql_meal_plan_ids)

    note_store = EvernoteApi.create_note_store(auth_token, evernote_host)
    note_notebook_guid = EvernoteApi.create_note_notebook_guid(note_notebook, auth_token, note_store)
    note_body = EvernoteApi.make_note_body(shopping_list) 
    note = EvernoteApi.make_note(note_store, note_title, note_body, auth_token, note_notebook_guid)
  end
end
