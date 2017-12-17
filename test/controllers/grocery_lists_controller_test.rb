require 'test_helper'

class GroceryListsControllerTest < ActionDispatch::IntegrationTest
  test "#new" do
    EvernoteApi.stub(:create_note, [], []) do
      get new_grocery_list_url, params: { meal_plan_ids: [meal_plans(:meal_plan).id] }

      assert_response :success
    end
  end
end
