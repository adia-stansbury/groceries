require 'rails_helper'

RSpec.describe MealPlan, type: :model do
  let(:recipe) { FactoryGirl.create(:recipe, name: 'Buttery Apple Banana') }
  let(:recipe2) { FactoryGirl.create(:recipe, name: 'Black Bean Soup') }
  let(:consumer) { FactoryGirl.create(:consumer) }
  let(:meal_plan) { FactoryGirl.create(:meal_plan) }
  let(:zinc) { FactoryGirl.create(:nutrient, name: 'Zinc, Zn') }
  let(:unit) { FactoryGirl.create(:unit) }
  let(:location) { FactoryGirl.create(:location) }
  let(:apple) do
    FactoryGirl.create(:ingredient, name: 'apple', location_id: location.id)
  end
  let(:peanut_butter) do
    FactoryGirl.create(:ingredient, name: 'peanut butter', location_id: location.id)
  end
  let(:black_beans) do
    FactoryGirl.create(:ingredient, name: 'black beans', location_id: location.id)
  end
  let(:zinc_in_apple) do
    FactoryGirl.create(
      :ingredient_nutrient,
      value: 0.04,
      unit: 'mg',
      nutrient_id: zinc.id,
      ingredient_id: apple.id
    )
  end
  let(:zinc_in_peanut_butter) do
    FactoryGirl.create(
      :ingredient_nutrient,
      value: 2.78,
      unit: 'mg',
      nutrient_id: zinc.id,
      ingredient_id: peanut_butter.id
    )
  end
  let(:zinc_in_black_beans) do
    FactoryGirl.create(
      :ingredient_nutrient,
      value: 0.54,
      unit: 'mg',
      nutrient_id: zinc.id,
      ingredient_id: black_beans.id
    )
  end
  let(:grams_of_apple_in_recipe) do
    FactoryGirl.create(
      :recipe_ingredient,
      recipe_id: recipe.id,
      ingredient_id: apple.id,
      amount_in_grams: 182.0
    )
  end
  let(:grams_of_peanut_butter_in_recipe) do
    FactoryGirl.create(
      :recipe_ingredient,
      recipe_id: recipe.id,
      ingredient_id: peanut_butter.id,
      amount_in_grams: 64.0
    )
  end
  let(:grams_of_black_beans_in_recipe) do
    FactoryGirl.create(
      :recipe_ingredient,
      recipe_id: recipe2.id,
      ingredient_id: black_beans.id,
      amount_in_grams: 850.0
    )
  end
  let(:meal_plan_recipe) do
    FactoryGirl.create(
      :meal_plan_recipe,
      recipe_id: recipe.id,
      meal_plan_id: meal_plan.id,
      number_of_recipes: 2
    )
  end
  let(:meal_plan_recipe2) do
    FactoryGirl.create(
      :meal_plan_recipe,
      recipe_id: recipe2.id,
      meal_plan_id: meal_plan.id,
      number_of_recipes: 1
    )
  end
  let(:meal_plan_recipe_1_day) do
    MealPlanRecipeDay.create(
      meal_plan_recipe_id: meal_plan_recipe.id,
      date: Date.yesterday
    )
  end
  let(:meal_plan_recipe_2_day) do
    MealPlanRecipeDay.create(
      meal_plan_recipe_id: meal_plan_recipe2.id,
      date: Date.today
    )
  end

  before do
    consumer
    location
    meal_plan
    unit
  end

  describe '.add_recipe_ids_to_build' do
    it 'returns mealplan with recipe ids' do
      mealplan = { recipe.name => { number_of_recipes: 2, first_day_recipe: true }}
      expected =
        {
          recipe.name =>
           { number_of_recipes: 2, first_day_recipe: true, recipe_id: recipe.id }
        }

      results = MealPlan.add_recipe_ids_to_build(mealplan)

      expect(results).to eq(expected)
    end
  end

  describe '.shopping_list' do
    it 'returns contents of shopping list' do
      grams_of_apple_in_recipe
      grams_of_peanut_butter_in_recipe
      grams_of_black_beans_in_recipe
      meal_plan_recipe
      meal_plan_recipe2
      FactoryGirl.create(
        :recipe_ingredient,
        recipe_id: recipe2.id,
        ingredient_id: apple.id
      )

      sql_meal_plan_ids = SqlFormatter.sql_ids([meal_plan.id])

      results = MealPlan.shopping_list(sql_meal_plan_ids)

      expected = [
        [3.0, "fruit", "apple", "Black Bean Soup; Buttery Apple Banana"],
        [1.0, "fruit", "black beans", "Black Bean Soup"],
        [2.0, "fruit", "peanut butter", "Buttery Apple Banana"]
      ]

      expect(results.rows).to match_array(expected)
    end
  end

  describe '#nutrient_intake' do
    context 'all recipes in meal plan with multiple recipes' do
      it 'returns total nutrient intake' do
        zinc_in_apple
        zinc_in_peanut_butter
        zinc_in_black_beans
        grams_of_apple_in_recipe
        grams_of_peanut_butter_in_recipe
        grams_of_black_beans_in_recipe
        meal_plan_recipe
        meal_plan_recipe2
        meal_plan_recipe_1_day
        meal_plan_recipe_2_day

        results = meal_plan.nutrient_intake(
          meal_plan.dates.first,
          meal_plan.dates.last
        )

        total_zinc = results.first['amt_consumed']

        expect(total_zinc).to eq(8.294)
      end
    end
  end

  describe '#nutrient_intake_from_custom_food' do
    let(:food) { FactoryGirl.create(:food) }
    let(:food_recipe) { FactoryGirl.create(:recipe, name: food.name) }
    let(:food_meal_plan_recipe) do
      FactoryGirl.create(
        :meal_plan_recipe,
        recipe_id: food_recipe.id,
        meal_plan_id: meal_plan.id,
        number_of_recipes: 1
      )
    end

    before do
      food_recipe
    end

    context 'meal plan does not contain custom food' do
      it 'returns 0' do
        results = meal_plan.nutrient_intake_from_custom_food(food, zinc.name)

        expect(results).to eq(0)
      end
    end

    context 'meal plan contains custom food and food has data for nutrient' do
      it 'returns nutrient intake from custom food' do
        food_meal_plan_recipe
        food_nutrition_for_zinc = FoodNutrient.create(
          nutrient_id: zinc.id,
          food_id: food.id,
          nutrient_amount: 2
        )

        results = meal_plan.nutrient_intake_from_custom_food(food, zinc.name)

        expect(results).to eq(2)
      end
    end

    context 'meal plan contains custom food but food has no data for nutrient' do
      it 'returns nutrient intake from custom food' do
        food_meal_plan_recipe

        results = meal_plan.nutrient_intake_from_custom_food(food, zinc.name)

        expect(results).to eq(0)
      end
    end
  end
end
