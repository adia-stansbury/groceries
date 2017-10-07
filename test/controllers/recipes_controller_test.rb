require 'test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recipe = recipes(:recipe)
    @recipe_params = { name: 'Grilled Prawn Salad' }
    @recipe_params_invalid = { name: nil }
  end

  test "should get index" do
    get recipes_url
    assert_response :success
  end

  test "should get new" do
    get new_recipe_url
    assert_response :success
  end

  test "should create recipe if valid" do
    assert_difference('Recipe.count') do
      post recipes_url, params: { recipe: @recipe_params }
    end

    assert_redirected_to recipe_url(Recipe.last)
  end

  test "does not create invalid recipe" do
    assert_difference('Recipe.count', 0) do
      post recipes_url, params: { recipe: @recipe_params_invalid }
    end

    assert_response :success
  end

  test "should show recipe" do
    get recipe_url(@recipe)
    assert_response :success
  end

  test "should get edit" do
    get edit_recipe_url(@recipe)
    assert_response :success
  end

  test "should update valid recipe" do
    patch recipe_url(@recipe), params: { recipe: @recipe_params }
    assert_redirected_to recipe_url(@recipe)
  end

  test "does not update recipe with invalid input" do
    patch recipe_url(@recipe), params: { recipe: @recipe_params_invalid }
    assert_response :success
  end

  test "should destroy recipe" do
    assert_difference('Recipe.count', -1) do
      delete recipe_url(@recipe)
    end

    assert_redirected_to recipes_url
  end
end
