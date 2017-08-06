require 'rails_helper'

RSpec.describe MealPlanRecipeDaysController, type: :request do
  describe 'GET show' do
    it 'renders the show template' do
      meal_plan = FactoryGirl.create(:meal_plan)
      FactoryGirl.create(:consumer)
      recipe = FactoryGirl.create(:recipe)
      FactoryGirl.create(
        :meal_plan_recipe,
        meal_plan_id: meal_plan.id,
        recipe_id: recipe.id
      )
      FactoryGirl.create(:nutrient_group)
      FactoryGirl.create(:food, name: 'Mealsquare')
      FactoryGirl.create(:food)

      get meal_plan_meal_plan_recipe_day_path(meal_plan.id, Date.today.iso8601)

      assert_response :success
    end
  end
end
