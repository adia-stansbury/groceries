require 'test_helper'

class IngredientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ingredient = ingredients(:ingredient)
    @ingredient_params = { location_id: @ingredient.location.id , name: 'salt' }
    @ingredient_params_invalid = { location_id: nil, name: 'salt' }
  end

  test "should get index" do
    get ingredients_url
    assert_response :success
  end

  test "should get new" do
    get new_ingredient_url
    assert_response :success
  end

  test "creates ingredient if valid" do
    assert_difference('Ingredient.count') do
      post ingredients_url, params: { ingredient: @ingredient_params }
    end

    assert_redirected_to ingredient_url(Ingredient.last)
  end

  test "does not create invalid ingredient" do
    assert_difference('Ingredient.count', 0) do
      post ingredients_url, params: { ingredient: @ingredient_params_invalid }
    end

    assert_redirected_to new_ingredient_url
  end

  test "should show ingredient" do
    get ingredient_url(@ingredient)
    assert_response :success
  end

  test "should get edit" do
    get edit_ingredient_url(@ingredient)
    assert_response :success
  end

  test "should update ingredient if valid" do
    patch ingredient_url(@ingredient), params: { ingredient: @ingredient_params }
    assert_redirected_to ingredient_url(@ingredient)
  end

  test "redirects to edit if updating invalid ingredient" do
    patch(
      ingredient_url(@ingredient),
      params: { ingredient: @ingredient_params_invalid }
    )

    assert_redirected_to edit_ingredient_url(@ingredient)
  end

  test "should destroy ingredient" do
    assert_difference('Ingredient.count', -1) do
      delete ingredient_url(@ingredient)
    end

    assert_redirected_to ingredients_url
  end
end
