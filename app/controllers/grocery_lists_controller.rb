class GroceryListsController < ApplicationController
  def new
    list = GroceryList.new(params['meal_plan_ids'] * ',').create
    EvernoteApi.new(list).create_note
  end
end
