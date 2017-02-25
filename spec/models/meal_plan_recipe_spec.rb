require 'rails_helper'

RSpec.describe MealPlanRecipe, type: :model do
  describe '.fetch_recipe_ids_with_flag' do
    it 'returns array of hashes of recipe id with flag' do
      recipe = FactoryGirl.create(:recipe)
      mealplan = [{ recipe_name: recipe.name, first_day_recipe: true }]

      expected = [{ recipe_id: recipe.id, first_day_recipe: true }]
      results = MealPlanRecipe.fetch_recipe_ids_with_flag(mealplan)

      expect(results).to match_array(expected)
    end
  end

  describe '.new_rows' do
    it 'returns rows to create' do
      recipe_ids_with_flag = [{ recipe_id: 2, first_day_recipe: true }]

      expected = [{ recipe_id: 2, number_of_recipes: 1, first_day_recipe: true }]
      results = MealPlanRecipe.new_rows(recipe_ids_with_flag)

      expect(results).to match_array(expected)
    end
  end
end
