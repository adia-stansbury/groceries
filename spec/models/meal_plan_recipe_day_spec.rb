require 'rails_helper'

RSpec.describe MealPlanRecipeDay, type: :model do
  let(:today) { Date.today.strftime("%F") }
  let(:meal_plan) { FactoryGirl.create(:meal_plan) }
  let(:recipe) { FactoryGirl.create(:recipe) }
  let(:meal_plan_recipe) do
    FactoryGirl.create(
      :meal_plan_recipe,
      meal_plan_id: meal_plan.id,
      recipe_id: recipe.id
    )
  end
  let(:recipe_ids_dates) { { recipe.id => [today] } }

  describe '.build' do
    it 'returns hash of meal_plan_recipe_day rows' do

      expected = [
        {
          meal_plan_recipe_id: meal_plan_recipe.id,
          date: today
        }
      ]

      results = MealPlanRecipeDay.build([meal_plan_recipe], recipe_ids_dates)

      expect(results).to eq(expected)
    end
  end

  describe '.fetch_recipe_ids_date_hash' do
    it 'returns hash of recipe ids and dates' do
      mealplan_with_recipe_ids = {
        recipe.name => { recipe_id: recipe.id, dates: [today] }
      }

      expected = { recipe.id => [today] }

      results = MealPlanRecipeDay.fetch_recipe_ids_date_hash(mealplan_with_recipe_ids)

      expect(results).to eq(expected)
    end
  end
end
