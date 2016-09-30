desc 'add daily_rda, UL, and nutrient unit info to db'
task add_daily_rda_to_db: :environment do
  def create_records(nutrient_record, micks_id, adias_id, micks_rda, adias_rda)
    ConsumerNutrient.create([
      consumer_nutrient_hash(nutrient_record, micks_id, micks_rda),
      consumer_nutrient_hash(nutrient_record, adias_id, adias_rda) 
    ])
  end 

  def add_unit_to_db(unit_name, nutrient_record)
    unit_id = Unit.find_or_create_by(name: unit_name).id
    nutrient_record.update_attribute(:unit_id, unit_id)
  end 

  def get_consumer_id(consumer_name)
    Consumer.where(name: consumer_name).first.id
  end 

  def consumer_nutrient_hash(nutrient_record, consumer_id, daily_rda)
    {
      nutrient_id: nutrient_record.id, 
      consumer_id: consumer_id,
      daily_rda: daily_rda
    }
  end 

  def weight_adjusted_rda(weight_in_lbs, rda)
    (rda * weight_in_lbs/2.2).round(2)
  end 

  micks_id = get_consumer_id('Mick')
  adias_id = get_consumer_id('Adia')

  ADIA_WEIGHT_LBS = Consumer.find(adias_id).weight_in_lbs
  MICK_WEIGHT_LBS = Consumer.find(micks_id).weight_in_lbs

  Nutrient.all.each do |nutrient_record|
    case nutrient_record.name 
    when 'Energy' 
      add_unit_to_db('kcal', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 3400, 2285)
    when 'Calcium, Ca'
      add_unit_to_db('mg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 1000, 1000)
    when 'Copper, Cu'
      add_unit_to_db('mg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 0.9, 0.9)
    when 'Iron, Fe'
      add_unit_to_db('mg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 8, 10)
    when 'Magnesium, Mg'
      add_unit_to_db('mg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 420, 310)
    when 'Manganese, Mn'
      add_unit_to_db('mg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 2.3, 1.8)
    when 'Phosphorus, P'
      add_unit_to_db('mg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 700, 700)
    when 'Potassium, K'
      add_unit_to_db('mg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 4700, 4700)
    when 'Selenium, Se'      
      add_unit_to_db('ug', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 55, 55)
    when 'Sodium, Na'
      add_unit_to_db('mg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 1500, 1500)
    when 'Zinc, Zn'
      add_unit_to_db('mg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 11, 8)
    when 'Fiber, total dietary'
      add_unit_to_db('g', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 38, 25)
    when 'Protein'
      add_unit_to_db('g', nutrient_record)
      create_records(
        nutrient_record, 
        micks_id, 
        adias_id,
        weight_adjusted_rda(MICK_WEIGHT_LBS, 0.8),
        weight_adjusted_rda(ADIA_WEIGHT_LBS, 0.8)
      )
    when 'Cystine'
      add_unit_to_db('g', nutrient_record)
      create_records(
        nutrient_record, 
        micks_id, 
        adias_id,
        weight_adjusted_rda(MICK_WEIGHT_LBS, 0.019),
        weight_adjusted_rda(ADIA_WEIGHT_LBS, 0.019)
      )
    when 'Histidine'
      add_unit_to_db('g', nutrient_record)
      create_records(
        nutrient_record, 
        micks_id, 
        adias_id,
        weight_adjusted_rda(MICK_WEIGHT_LBS, 0.014), 
        weight_adjusted_rda(ADIA_WEIGHT_LBS, 0.014)
      )
    when 'Isoleucine'
      add_unit_to_db('g', nutrient_record)
      create_records(
        nutrient_record, 
        micks_id, 
        adias_id,
        weight_adjusted_rda(MICK_WEIGHT_LBS, 0.019),
        weight_adjusted_rda(ADIA_WEIGHT_LBS, 0.019)
      )
    when 'Leucine'
      add_unit_to_db('g', nutrient_record)
      create_records(
        nutrient_record, 
        micks_id, 
        adias_id,
        weight_adjusted_rda(MICK_WEIGHT_LBS, 0.042),
        weight_adjusted_rda(ADIA_WEIGHT_LBS, 0.042)
      )
    when 'Lysine'
      add_unit_to_db('g', nutrient_record)
      create_records(
        nutrient_record, 
        micks_id, 
        adias_id,
        weight_adjusted_rda(MICK_WEIGHT_LBS, 0.038),
        weight_adjusted_rda(ADIA_WEIGHT_LBS, 0.038)
      )
    when 'Methionine'
      add_unit_to_db('g', nutrient_record)
      create_records(
        nutrient_record, 
        micks_id, 
        adias_id,
        weight_adjusted_rda(MICK_WEIGHT_LBS, 0.019),
        weight_adjusted_rda(ADIA_WEIGHT_LBS, 0.019)
      )
    when 'Phenylalanine'
      add_unit_to_db('g', nutrient_record)
      create_records(
        nutrient_record, 
        micks_id, 
        adias_id,
        weight_adjusted_rda(MICK_WEIGHT_LBS, 0.033),
        weight_adjusted_rda(ADIA_WEIGHT_LBS, 0.033)
      )
    when 'Threonine'
      add_unit_to_db('g', nutrient_record)
      create_records(
        nutrient_record, 
        micks_id, 
        adias_id,
        weight_adjusted_rda(MICK_WEIGHT_LBS, 0.020),
        weight_adjusted_rda(ADIA_WEIGHT_LBS, 0.020)
      )
    when 'Tryptophan'  
      add_unit_to_db('g', nutrient_record)
      create_records(
        nutrient_record, 
        micks_id, 
        adias_id,
        weight_adjusted_rda(MICK_WEIGHT_LBS, 0.005),
        weight_adjusted_rda(ADIA_WEIGHT_LBS, 0.005)
      )
    when 'Tyrosine'  
      add_unit_to_db('g', nutrient_record)
      create_records(
        nutrient_record, 
        micks_id, 
        adias_id,
        weight_adjusted_rda(MICK_WEIGHT_LBS, 0.033),
        weight_adjusted_rda(ADIA_WEIGHT_LBS, 0.033)
      )
    when 'Valine'  
      add_unit_to_db('g', nutrient_record)
      create_records(
        nutrient_record, 
        micks_id, 
        adias_id,
        weight_adjusted_rda(MICK_WEIGHT_LBS, 0.024),
        weight_adjusted_rda(ADIA_WEIGHT_LBS, 0.024)
      )
    when 'Choline, total' 
      add_unit_to_db('mg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 550, 425)
    when 'Folate, DFE'
      add_unit_to_db('µg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 400, 400)
    when 'Folate, food'
      add_unit_to_db('µg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 400, 400)
    when 'Folate, total'
      add_unit_to_db('µg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 400, 400)
    when 'Niacin' 
      add_unit_to_db('mg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 14, 14)
    'Pantothenic acid' 
      add_unit_to_db('mg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 5, 5)
    'Riboflavin'
      add_unit_to_db('mg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 1.1, 1.1)
    'Thiamin'
      add_unit_to_db('mg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 1.2, 1.1)
    'Vitamin A, RAE'
      add_unit_to_db('µg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 900, 700)
    'Vitamin B-12' 
      add_unit_to_db('µg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 2.4, 2.4)
    'Vitamin B-6' 
      add_unit_to_db('mg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 1.3, 1.3)
    'Vitamin C, total ascorbic acid'
      add_unit_to_db('mg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 90, 75)
    'Vitamin D'
      add_unit_to_db('µg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 5, 5)
    'Vitamin E (alpha-tocopherol)'
      add_unit_to_db('mg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 15, 15)
    'Vitamin K (phylloquinone)' 
      add_unit_to_db('µg', nutrient_record)
      create_records(nutrient_record, micks_id, adias_id, 120, 90)
    end 
  end 
end 
