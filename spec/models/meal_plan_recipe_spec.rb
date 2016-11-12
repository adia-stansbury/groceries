require 'rails_helper'

RSpec.describe MealPlanRecipe, type: :model do
  describe '.new_rows' do
    it 'returns rows to create' do
      recipe = FactoryGirl.create(:recipe)
      recipe_names = [recipe.name]

      results = MealPlanRecipe.new_rows(recipe_names)
      expected = [{ recipe_id: recipe.id, number_of_recipes: 1 }]

      expect(results).to eq(expected)
    end 
  end 
end 
