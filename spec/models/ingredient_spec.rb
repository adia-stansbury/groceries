require 'rails_helper'
require Rails.root.join "spec/models/concerns/clean_up_user_input_spec.rb"

RSpec.describe Ingredient, type: :model do
  it_behaves_like 'clean_up_user_input'

  describe '.create_ingredient_nutrient_records' do
    context 'after saving ingredient with ndbno' do
      it 'adds nutrient info for ingredient to db' do
        nutrient = FactoryGirl.create(:nutrient, name: 'Zinc, Zn')
        location = FactoryGirl.create(:location)
        ingredient = FactoryGirl.create(
          :ingredient, 
          ndbno: '11233', 
          name: 'kale', 
          location_id: location.id
        )

        zinc_nutrition = nutrient.ingredient_nutrients.where(
          ingredient_id: ingredient.id
        ).first

        expect(zinc_nutrition.value).to eq(0.56)
        expect(zinc_nutrition.unit).to eq('mg')
      end 
    end 
  end 
end
