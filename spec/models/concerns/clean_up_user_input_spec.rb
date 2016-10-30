require 'rails_helper'

shared_examples_for 'clean_up_user_input' do
  describe '.remove_extraneous_characters' do
    it 'calls chomp and strip on an object before it is saved' do
      location = FactoryGirl.create(:location)
      ingredient = FactoryGirl.create(
        :ingredient, 
        name: ' celery ', 
        location_id: location.id
      )

      expect(ingredient.reload.name).to eq('celery')
    end 
  end 
end 
