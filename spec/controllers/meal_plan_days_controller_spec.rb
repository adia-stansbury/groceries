require 'rails_helper'

RSpec.describe MealPlanDaysController, type: :request do
  describe 'GET show' do
    it 'renders the show template' do
      meal_plan = FactoryGirl.create(:meal_plan_recipe).meal_plan
      FactoryGirl.create(:nutrient_group)
      FactoryGirl.create(:food_mealsquare)
      FactoryGirl.create(:food_soylent)

      get meal_plan_meal_plan_day_path(meal_plan.id, Date.today.iso8601)

      assert_response :success
    end
  end
end
