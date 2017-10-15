require 'test_helper'

class MealPlansControllerTest < ActionDispatch::IntegrationTest
  test "should get index when there are meal plans" do
    meal_plans(:meal_plan)

    get meal_plans_url

    assert_response :success
  end

  test "should create meal_plan" do
    consumers(:adia, :mick)

    GoogleCalendarApi.stub :events_items, {} do
      assert_difference('MealPlan.count', 2 ) do
        post meal_plans_url, params: { 'start_date' => Date.new(2018,9,19) }
      end
    end

    assert_redirected_to meal_plans_url
  end

  test "should create meal plan's associated records" do
    consumers(:adia, :mick)
    items = [
      OpenStruct.new(
        start: OpenStruct.new(date: "2017-10-07"),
        summary: Recipe.first.name,
      )
    ]

    GoogleCalendarApi.stub :events_items, items do
      assert_difference('MealPlanRecipe.count', 2) do
        post meal_plans_url, params: { 'start_date' => Date.new(2017,10,07) }
      end
    end

    assert_redirected_to meal_plans_url
  end

  test "does not create a MealPlanRecipe for recipe name not in database" do
    consumers(:adia, :mick)
    items = [
      OpenStruct.new(
        start: OpenStruct.new(date: "2017-10-07"),
        summary: 'non existent recipe',
      )
    ]

    GoogleCalendarApi.stub :events_items, items do
      assert_difference('MealPlanRecipe.count', 0) do
        post meal_plans_url, params: { 'start_date' => Date.new(2017,10,07) }
      end
    end

    assert_redirected_to meal_plans_url
  end

  test "should show meal_plan" do
    meal_plan = meal_plans(:meal_plan)

    get meal_plan_url(meal_plan)

    assert_response :success
  end
end
