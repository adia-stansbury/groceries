require 'spec_helper'

shared_examples_for 'recipe_nutrient_intake' do
  let(:recipe) { FactoryGirl.create(:recipe, name: 'Buttery Apple Banana') } 
  let(:recipe2) { FactoryGirl.create(:recipe, name: 'Black Bean Soup') } 
  let(:zinc) { FactoryGirl.create(:nutrient, name: 'Zinc, Zn') } 
  let(:unit) { FactoryGirl.create(:unit) }  
  let(:location) { FactoryGirl.create(:location) } 
  let(:apple) do  
    FactoryGirl.create(:ingredient, name: 'apple', location_id: location.id)
  end 
  let(:peanut_butter) do  
    FactoryGirl.create(:ingredient, name: 'peanut butter', location_id: location.id)
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
    
  it 'calculates nutrient intake for recipe with one ingredient' do
    unit
    location
    zinc_in_apple
    grams_of_apple_in_recipe

    results = Recipe.nutrient_intake(recipe.id)
    total_zinc = results.first['amt_consumed']
    
    expect(total_zinc).to eq('0.0728')
  end 

  it 'calculates nutrient intake for recipe with two different ingredients' do
    unit
    location
    zinc_in_apple
    grams_of_apple_in_recipe
    zinc_in_peanut_butter
    grams_of_peanut_butter_in_recipe

    results = Recipe.nutrient_intake(recipe.id)
    total_zinc = results.first['amt_consumed']
    
    expect(total_zinc).to eq('1.852')
  end 
end 
