require 'test_helper'

class MealPlanDaysControllerTest < ActionDispatch::IntegrationTest
  test 'should show meal_plan_day' do
    meal_plan = create(:meal_plan_recipe).meal_plan
    create(:nutrient_group)
    create(:food_mealsquare)
    create(:food_soylent)

    get meal_plan_meal_plan_day_path(meal_plan.id, Date.today.iso8601)

    assert_response :success
  end
end
