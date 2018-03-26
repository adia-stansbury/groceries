require 'test_helper'

class RecipeIngredientTest < ActiveSupport::TestCase
  test "#create_ingredient_nutrients after creating a RecipeIngredient" do
    nutrient = nutrients(:nutrient)
    nutrition = [{ 'name' => nutrient.name, 'value' => 10, 'unit' => 'mg' }]

    Nutrition.stub :for_ingredient, nutrition do
      assert_difference('IngredientNutrient.count') do
        RecipeIngredient.create(recipe: recipes(:recipe), ingredient: ingredients(:ingredient_with_ndbno))
      end
    end
  end
end
