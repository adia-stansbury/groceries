require 'test_helper'

class MealPlansControllerTest < ActionDispatch::IntegrationTest
  test "should get index when there are meal plans" do
    meal_plans(:meal_plan)

    get meal_plans_url

    assert_response :success
  end

  test "should create meal_plan" do
    consumers(:adia, :mick)

    assert_difference('MealPlan.count', 2 ) do
      post meal_plans_url, params: { 'start_date' => Date.today }
    end

    assert_response :success
  end

  test "should show meal_plan" do
    meal_plan = meal_plans(:meal_plan)

    get meal_plan_url(meal_plan)

    assert_response :success
  end
end
