class GroceryListsController < ApplicationController
  def new
    sql_meal_plan_ids = SqlFormatter.sql_ids(params['meal_plan_ids'])
    list = GroceryList.new(sql_meal_plan_ids).create
    EvernoteApi.new(list).create_note
  end
end
