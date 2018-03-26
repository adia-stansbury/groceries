require 'test_helper'

class ImportFoodsControllerTest < ActionDispatch::IntegrationTest
  test "#create ingredients" do
      location = locations(:location)
      recipe_id = 10
      search_term_params = { ingredient_search_term: 'search term', recipe_id: recipe_id }
      mock = Minitest::Mock.new
      mock.expect :search_results, [{ 'ndbno' => 10090, 'name' => 'food name' }]
      mock.expect :ingredient_attributes, [{ 'ndbno' => 10090, 'name' => 'food name', location_id: location.id }]

      FoodListService.stub :new, mock do
        assert_difference('Ingredient.count') do
          post import_foods_url, params: search_term_params
        end
      end

      assert_mock mock
      assert_redirected_to recipe_url(recipe_id)
    end
end
