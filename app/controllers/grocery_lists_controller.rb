class GroceryListsController < ApplicationController
  def new
    @list = GroceryList.new(params['meal_plan_ids'] * ',').create
    # TODO: add UI option to send note to Evernote
    # EvernoteApi.new(@list).create_note
  end
end
