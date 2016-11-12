require 'rails_helper'
require Rails.root.join "spec/models/concerns/clean_up_user_input_spec.rb"

RSpec.describe Ingredient, type: :model do
  it_behaves_like 'clean_up_user_input'

  describe '#create_ingredient_nutrient_records' do
    context 'after saving ingredient with ndbno' do
      it 'adds nutrient info for ingredient to db' do
        nutrient = FactoryGirl.create(:nutrient)
        location = FactoryGirl.create(:location)
        ingredient = FactoryGirl.create(
          :ingredient, 
          location_id: location.id, 
          ndbno: '11233'
        ) 

        nutrition = nutrient.ingredient_nutrients.where(
          ingredient_id: ingredient.id
        ).first

        expect(nutrition.value).to eq(0.56)
        expect(nutrition.unit).to eq('mg')
      end 
    end 
  end 
end
