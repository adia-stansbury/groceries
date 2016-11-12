require 'rails_helper'

RSpec.describe Nutrient, type: :model do
  describe '.upper_limit_hash' do
    context 'nutrient has an upper limit' do
      it 'returns hash of nutrient name and its upper limit' do
        nutrient = FactoryGirl.create(:nutrient, upper_limit: 45) 

        expected = { nutrient.name => 45 }

        expect(Nutrient.upper_limit_hash).to eq(expected)
      end
    end 
    context 'nutrient has no upper limit' do
      it 'returns empty hash' do
        nutrient = FactoryGirl.create(:nutrient) 

        expect(Nutrient.upper_limit_hash).to eq({})
      end
    end 
  end 
end 
