require 'rails_helper'
require 'rake'

describe 'add_daily_rda_to_db' do
  let(:rake)      { Rake::Application.new }
  let(:task_path) { "lib/tasks/add_daily_rda_to_db" }
  subject         { rake['add_daily_rda_to_db'] }

  let(:energy_nutrient_record) { FactoryGirl.create(:nutrient, name: 'Energy') }
  let(:calcium_nutrient_record) { FactoryGirl.create(:nutrient, name: 'Calcium, Ca') }
  let(:protein_nutrient_record) { FactoryGirl.create(:nutrient, name: 'Protein') }
  let(:adia) { FactoryGirl.create(:consumer) }
  let(:mick) do  
    FactoryGirl.create(
      :consumer, 
      name: 'Mick', 
      id: 2, 
      weight_in_lbs: 204
    )
  end 

  def loaded_files_excluding_current_rake_file
    $".reject {|file| file == Rails.root.join("#{task_path}.rake").to_s }
  end

  before do
    Rake.application = rake
    Rake.application.rake_require(
      task_path, 
      [Rails.root.to_s], 
      loaded_files_excluding_current_rake_file
    )

    Rake::Task.define_task(:environment)

    adia
    mick
    energy_nutrient_record
    calcium_nutrient_record
    protein_nutrient_record

    subject.invoke
  end

  context 'nutrient is Energy' do
    let(:mick_result) { ConsumerNutrient.where(daily_rda: 3400).first }
    let(:adia_result) { ConsumerNutrient.where(daily_rda: 2285).first }

    it 'creates ConsumerNutrient records with the correct data' do
      expect(mick_result.consumer_id).to eq(mick.id)
      expect(mick_result.nutrient_id).to eq(energy_nutrient_record.id)
      expect(adia_result.consumer_id).to eq(adia.id)
      expect(adia_result.nutrient_id).to eq(energy_nutrient_record.id)
    end 

    it 'adds unit_id to Nutrient' do
      nutrient = Nutrient.find(mick_result.nutrient_id)

      expect(nutrient.unit.name).to eq('kcal')
    end 
  end 

  context 'nutrient is Calcium' do
    let(:mick_result) do 
      ConsumerNutrient.where(
        nutrient_id: calcium_nutrient_record.id, 
        consumer_id: mick.id
      ).first 
    end 
    let(:adia_result) do 
      ConsumerNutrient.where(
        nutrient_id: calcium_nutrient_record.id, 
        consumer_id: adia.id
      ).first 
    end 

    it 'creates ConsumerNutrient records with the correct data' do
      expect(mick_result.daily_rda).to eq(1000)
      expect(adia_result.daily_rda).to eq(1000)
    end 

    it 'adds unit_id to Nutrient' do
      nutrient = Nutrient.find(mick_result.nutrient_id)

      expect(nutrient.unit.name).to eq('mg')
    end 
  end 

  context 'nutrient is Protein' do
    let(:mick_result) do 
      ConsumerNutrient.where(
        nutrient_id: protein_nutrient_record.id, 
        consumer_id: mick.id
      ).first 
    end 
    let(:adia_result) do 
      ConsumerNutrient.where(
        nutrient_id: protein_nutrient_record.id, 
        consumer_id: adia.id
      ).first 
    end 

    it 'creates ConsumerNutrient records with the correct data' do
      expect(mick_result.daily_rda).to eq(74.18)
      expect(adia_result.daily_rda).to eq(45.09)
    end 

    it 'adds unit_id to Nutrient' do
      nutrient = Nutrient.find(mick_result.nutrient_id)

      expect(nutrient.unit.name).to eq('g')
    end 
  end 
end 
