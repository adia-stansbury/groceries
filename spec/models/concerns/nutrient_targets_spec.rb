require 'spec_helper'

shared_examples_for 'nutrient_targets' do
  let(:consumer) { FactoryGirl.create(:consumer).name }
  let(:meal_plan) { FactoryGirl.create(:meal_plan) }
  let(:meal_plan_with_soylent) { FactoryGirl.create(:meal_plan) }
  let(:soylent) { FactoryGirl.create(:recipe, name: 'Soylent') } 
  let(:meal_plan_recipe_soylent) do 
    FactoryGirl.create(
      :meal_plan_recipe,
      recipe_id: soylent.id,
      meal_plan_id: meal_plan_with_soylent.id
    )
  end 
  let(:zinc_record) do 
    {
      'id' => '34', 
      'name' => 'Zinc, Zn', 
      'amt_consumed_unit' => 'mg', 
      'amt_consumed' => '3.704'
    }
  end 
  let(:sodium_record) do 
    {
      'id' => '35', 
      'name' => 'Sodium, Na', 
      'amt_consumed_unit' => 'mg', 
      'amt_consumed' => '300'
    }
  end 

  it 'returns total nutrient intake for mealplan without soylent or mealsquare' do
    results = IngredientNutrient.total_nutrient_intake(
      zinc_record, 
      meal_plan, 
      consumer
    )

    expect(results).to eq(3.7)
  end 

  it 'returns nutrient intake for mealplan with soylent, with percent of rda given' do
    meal_plan_recipe_soylent

    results = IngredientNutrient.total_nutrient_intake(
      zinc_record, 
      meal_plan_with_soylent, 
      consumer
    )

    expect(results).to eq(5.7)
  end 

  it 'returns nutrient intake for mealplan with soylent, using raw num as input' do
    meal_plan_recipe_soylent

    results = IngredientNutrient.total_nutrient_intake(
      sodium_record, 
      meal_plan_with_soylent, 
      consumer
    )

    expect(results).to eq(680)
  end 
end 
