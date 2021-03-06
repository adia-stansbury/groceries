require 'test_helper'

class MealPlanRecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @meal_plan_recipe = meal_plan_recipes(:meal_plan_recipe)
    recipe = recipes(:recipe)
    @meal_plan_recipe_params = { recipe_id: recipe.id, date: Date.today }
  end

  test "should create meal_plan_recipe" do
    meal_plan = meal_plans(:meal_plan)

    assert_difference('MealPlanRecipe.count') do
      post meal_plan_meal_plan_recipes_url(meal_plan), params: {
        meal_plan_recipe: @meal_plan_recipe_params
      }
    end

    assert_redirected_to meal_plan_url(meal_plan.id)
  end

  test "should destroy meal_plan_recipe" do
    assert_difference('MealPlanRecipe.count', -1) do
      delete meal_plan_recipe_url(@meal_plan_recipe)
    end

    assert_redirected_to meal_plan_url(@meal_plan_recipe.meal_plan)
  end
end
