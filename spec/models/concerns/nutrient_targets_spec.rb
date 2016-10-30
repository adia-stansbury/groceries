require 'rails_helper'

shared_examples_for 'nutrient_targets' do
  describe '.total_nutrient_intake' do
    let(:zinc_record) do 
      {
        'id' => '34', 
        'name' => 'Zinc, Zn', 
        'amt_consumed_unit' => 'mg', 
        'amt_consumed' => '3.704'
      }
    end 

    context 'mealplan does not include soylent or mealsquare' do
      it 'returns total intake for a nutrient' do
        mealsquare_nutrition = {}
        soylent_nutrition = {}

        results = IngredientNutrient.total_nutrient_intake(
          zinc_record, 
          mealsquare_nutrition,
          soylent_nutrition
        )

        expect(results).to eq(3.7)
      end 
    end 

    context 'mealplan includes soylent and mealsquare' do 
      it 'returns total intake for a nutrient' do
        soylent_nutrition = {'Zinc, Zn'=>5.0, 'Sodium, Na'=>200.0} 
        mealsquare_nutrition = {'Zinc, Zn'=>4.0, 'Sodium, Na'=>500.0} 

        results = IngredientNutrient.total_nutrient_intake(
          zinc_record, 
          mealsquare_nutrition,
          soylent_nutrition
        )

        expect(results).to eq(12.7)
      end 
    end 
  end 
end 
