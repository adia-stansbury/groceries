require 'test_helper'

class MealPlanDaysControllerTest < ActionDispatch::IntegrationTest
  test 'should show meal_plan_day' do
    meal_plan = meal_plan_recipes(:meal_plan_recipe).meal_plan
    nutrient_groups(:nutrient_group)
    foods(:mealsquare, :soylent)

    get meal_plan_meal_plan_day_path(meal_plan.id, Date.today.iso8601)

    assert_response :success
  end
end
