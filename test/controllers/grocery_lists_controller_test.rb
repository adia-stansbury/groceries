require 'test_helper'

class GroceryListsControllerTest < ActionDispatch::IntegrationTest
  test "#new" do
    # mock = Minitest::Mock.new
    # mock.expect :create_note, []

    # EvernoteApi.stub :new, mock do
      get new_grocery_list_url, params: { meal_plan_ids: [meal_plans(:meal_plan).id] }

      assert_response :success
    # end

    # assert_mock mock
  end
end
