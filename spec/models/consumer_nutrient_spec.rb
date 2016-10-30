require 'rails_helper'

RSpec.describe ConsumerNutrient, type: :model do
  describe '.daily_rda' do
    it "returns consumer's daily RDA for a nutrient" do
      nutrient = FactoryGirl.create(:nutrient, name: 'Zinc, Zn')
      consumer = FactoryGirl.create(:consumer)
      consumer_nutrient = FactoryGirl.create(
        :consumer_nutrient, 
        consumer_id: consumer.id,
        nutrient_id: nutrient.id,
        daily_rda: 8
      )
      consumer_rdas = Consumer.rda_hash(consumer.name)

      results = ConsumerNutrient.daily_rda(
        nutrient.name, 
        consumer_rdas
      )

      expect(results).to eq(8)
    end 
  end 

  describe '.weekly_rda' do
    it "returns consumer's weekly RDA for a nutrient" do
      daily_rda = 8.45

      results = ConsumerNutrient.weekly_rda(daily_rda)

      expect(results).to eq(59.15)
    end 
  end 
end 
