require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe '#capitalize_recipe_name' do 
    it 'returns recipe name capitalized' do 
      recipe = FactoryGirl.build(:recipe, name: 'black bean soup')

      expect(recipe.send(:capitalize_recipe_name!)).to eq('Black Bean Soup')
    end 
  end 
end
