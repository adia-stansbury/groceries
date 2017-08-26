require 'test_helper'

class RecipeIngredientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recipe = recipes(:recipe)
    ingredient = ingredients(:ingredient)
    @recipe_ingredient = recipe_ingredients(:recipe_ingredient)
    @recipe_ingredient_params = { ingredient_id: ingredient.id }
  end

  test "should create recipe_ingredient" do
    assert_difference('RecipeIngredient.count') do
      post recipe_recipe_ingredients_url(@recipe), params: {
        recipe_ingredient: @recipe_ingredient_params
      }
    end

    assert_redirected_to recipe_url(@recipe)
  end

  test "should get edit" do
    get edit_recipe_ingredient_url(@recipe_ingredient)

    assert_response :success
  end

  test "should update recipe_ingredient" do
    patch recipe_ingredient_url(@recipe_ingredient), params: {
      recipe_ingredient: @recipe_ingredient_params
    }

    assert_redirected_to recipe_url(@recipe)
  end

  test "should destroy recipe_ingredient" do
    assert_difference('RecipeIngredient.count', -1) do
      delete recipe_ingredient_url(@recipe_ingredient)
    end

    assert_redirected_to recipe_url(@recipe)
  end
end
