require 'rails_helper'

RSpec.describe MealPlanRecipe, type: :model do
  describe '.new_rows' do
    it 'returns rows to create' do
      mealplan_with_recipe_ids =
        { 'Roasted Veggies' =>
         { number_of_recipes: 2, first_day_recipe: true, recipe_id: 5 }
        }

      expected = [{ recipe_id: 5, number_of_recipes: 2, first_day_recipe: true }]
      results = MealPlanRecipe.new_rows(mealplan_with_recipe_ids)

      expect(results).to eq(expected)
    end
  end
end
