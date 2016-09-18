module NutrientTargets
  extend ActiveSupport::Concern 

  module ClassMethods
    ADIA_WEIGHT_LBS = 122
    MICK_WEIGHT_LBS = 201

    def daily_rda_hash
      {
        'Energy': create_goal_hash('kcal', 3400, 2285),
        'Calcium, Ca': create_goal_hash('mg', 1000, 1000),
        'Copper, Cu': create_goal_hash('mg', 0.9, 0.9),
        'Iron, Fe': create_goal_hash('mg', 8, 10, 45),
        'Magnesium, Mg': create_goal_hash('mg', 420, 310),
        'Manganese, Mn': create_goal_hash('mg', 2.3, 1.8),
        'Phosphorus, P': create_goal_hash('mg', 700, 700),
        'Potassium, K': create_goal_hash('mg', 4700, 4700),
        'Selenium, Se': create_goal_hash('ug', 55, 55),
        'Sodium, Na': create_goal_hash('mg', 1500, 1500),
        'Zinc, Zn': create_goal_hash('mg', 11, 8),
        'Fiber, total dietary': create_goal_hash('g', 38, 25),
        'Protein': create_goal_hash(
          'g',
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 0.8),
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 0.8)
        ),
        'Alanine': create_goal_hash('no RDA', 0, 0),
        'Arginine': create_goal_hash('no RDA', 0, 0),
        'Aspartic acid': create_goal_hash('no RDA', 0, 0),
        'Cystine': create_goal_hash(
          'g',
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 0.019),
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 0.019)
        ),
        'Glutamic acid': create_goal_hash('no RDA', 0, 0),
        'Glycine': create_goal_hash('no RDA', 0, 0),
        'Histidine': create_goal_hash(
          'g', 
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 0.014), 
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 0.014)
        ),
        'Isoleucine': create_goal_hash(
          'g',
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 0.019),
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 0.019)
        ),
        'Leucine': create_goal_hash(
          'g',
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 0.042),
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 0.042)
        ),
        'Lysine': create_goal_hash(
          'g',
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 0.038),
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 0.038)
        ),
        'Methionine': create_goal_hash(
          'g',
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 0.019),
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 0.019)
        ),
        'Phenylalanine': create_goal_hash(
          'g',
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 0.033),
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 0.033)
        ),
        'Proline': create_goal_hash('no RDA', 0, 0),
        'Serine': create_goal_hash('no RDA', 0, 0),
        'Threonine': create_goal_hash(
          'g',
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 0.020),
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 0.020)
        ),
        'Tryptophan': create_goal_hash(
          'g',
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 0.005),
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 0.005)
        ),
        'Tyrosine': create_goal_hash(
          'g',
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 0.033),
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 0.033)
        ),
        'Valine': create_goal_hash(
          'g',
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 0.024),
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 0.024)
        ),
        'Betaine': create_goal_hash('no RDA', 0, 0),
        'Carotene, alpha': create_goal_hash('no RDA', 0, 0),
        'Carotene, beta': create_goal_hash('no RDA', 0, 0),
        'Choline, total': create_goal_hash('mg', 550, 425), 
        'Folate, DFE': create_goal_hash('µg', 400, 400),
        'Folate, food': create_goal_hash('µg', 400, 400),
        'Folate, total': create_goal_hash('µg', 400, 400),
        'Folic acid': create_goal_hash('no RDA', 0, 0),
        'Lutein + zeaxanthin': create_goal_hash('no RDA', 0, 0),
        'Lycopene': create_goal_hash('no RDA', 0, 0),
        'Niacin': create_goal_hash('mg', 14, 14), 
        'Pantothenic acid': create_goal_hash('mg', 5, 5), 
        'Retinol': create_goal_hash('no RDA', 0, 0),
        'Riboflavin': create_goal_hash('mg', 1.1, 1.1),
        'Thiamin': create_goal_hash('mg', 1.2, 1.1),
        'Vitamin A, IU': create_goal_hash('no RDA', 0, 0),
        'Vitamin A, RAE': create_goal_hash('µg', 900, 700),
        'Vitamin B-12': create_goal_hash('µg', 2.4, 2.4), 
        'Vitamin B-6': create_goal_hash('mg', 1.3, 1.3), 
        'Vitamin C, total ascorbic acid': create_goal_hash('mg', 90, 75),
        'Vitamin D': create_goal_hash('µg', 5, 5),
        'Vitamin D (D2 + D3)': create_goal_hash('no RDA', 0, 0),
        'Vitamin E (alpha-tocopherol)': create_goal_hash('mg', 15, 15),
        'Vitamin K (phylloquinone)': create_goal_hash('µg', 120, 90) 
      }
    end 

    SOYLENT_NUTRIENTS_AT_25_PERCENT_DAILY_RDA = [ 
      'Calcium, Ca', 
      'Choline, total', 
      'Chromium', 
      'Copper, Cu',
      'Folic Acid',
      'Iron, Fe',
      'Magnesium, Mg',
      'Manganese, Mn',
      'Niacin',
      'Potassium, K',
      'Riboflavin',
      'Selenium, Se',
      'Thiamin',
      'Vitamin A, RAE',
      'Vitamin B-12',
      'Vitamin B-6',
      'Vitamin C, total ascorbic acid',
      'Vitamin D', 
      'Vitamin E (alpha-tocopherol)',
      'Vitamin K (phylloquinone)',
      'Zinc, Zn',
    ]

    MEALSQUARE_NUTRIENTS_AT_20_PERCENT_DAILY_RDA = [
      'Calcium, Ca',
      'Folic Acid',
      'Iron, Fe',
      'Niacin',
      'Riboflavin',
      'Selenium, Se',
      'Thiamin',
      'Vitamin A, RAE',
      'Vitamin B-6',
      'Vitamin E (alpha-tocopherol)'
    ]

    def has_rda(nutrient_name_symbol)
      daily_rda_hash[nutrient_name_symbol][:unit] != 'no RDA'
    end 

    def daily_rda(nutrient_name_symbol, consumer_symbol)
      daily_rda_hash[nutrient_name_symbol][:amount][consumer_symbol].to_f.round(2)
    end 

    def weekly_rda(nutrient_name_symbol, consumer_symbol)
      (daily_rda_hash[nutrient_name_symbol][:amount][consumer_symbol] * 7).to_f.round(2)
    end 

    def percent_rda(intake, rda)
      (intake.to_i.to_f/rda * 100).round(2)
    end 

    def has_upper_limit(nutrient_name_symbol)
      daily_rda_hash[nutrient_name_symbol][:UL] != 'N/A'  
    end 

    def daily_upper_limit(nutrient_name_symbol)
      daily_rda_hash[nutrient_name_symbol][:UL]  
    end 

    def weekly_upper_limit(nutrient_name_symbol)
      daily_rda_hash[nutrient_name_symbol][:UL] * 7  
    end 

    def unit(nutrient_name_symbol)
      daily_rda_hash[nutrient_name_symbol][:unit]
    end 

    def total_nutrient_intake(record, mealplan, consumer)
      if mealplan.recipes.pluck(:name).include?('Soylent')
        if SOYLENT_NUTRIENTS_AT_25_PERCENT_DAILY_RDA.include?(record['name'])
          soylent_nutrient_intake = convert_percent_intake_to_raw_num(
            25, 
            record,
            symbolized_nutrient_name(record),            
            consumer.to_sym
          ) 
        elsif 
          case record['name'] 
          when 'Energy'
            soylent_nutrient_intake = 500
          when 'Sodium, Na'
            soylent_nutrient_intake = 380
          when  'Fiber, total dietary'
            soylent_nutrient_intake = 7
          when 'Sugars, total'
            soylent_nutrient_intake = 19
          when 'Total lipid (fat)'
            soylent_nutrient_intake = 25 
          when 'Fatty acids, total monounsaturated'
            soylent_nutrient_intake = 17
          when 'Fatty acids, total polyunsaturated'
            soylent_nutrient_intake = 4.5 
          when 'Fatty acids, total saturated'
            soylent_nutrient_intake = 2.5 
          when 'Fatty acids, total trans'
            soylent_nutrient_intake = 0 
          when 'Cholesterol'
            soylent_nutrient_intake = 0
          when 'Carbohydrate, by difference'
            soylent_nutrient_intake = 47
          when 'Protein'
            soylent_nutrient_intake = 25
          end 
        end 
      end 
      if mealplan.recipes.pluck(:name).include?('MealSquare')
        if MEALSQUARE_NUTRIENTS_AT_20_PERCENT_DAILY_RDA.include?(record['name'])
          mealsquare_nutrient_intake = convert_percent_intake_to_raw_num(
            20, 
            record,
            symbolized_nutrient_name(record),            
            consumer.to_sym
          ) 
        elsif 
          case record['name'] 
          when 'Energy'
            mealsquare_nutrient_intake = 400
          when 'Sodium, Na'
            mealsquare_nutrient_intake = 529
          when  'Fiber, total dietary'
            mealsquare_nutrient_intake = 5.5
          when 'Sugars, total'
            mealsquare_nutrient_intake = 17
          when 'Total lipid (fat)'
            mealsquare_nutrient_intake = 20 
          when 'Fatty acids, total monounsaturated'
            mealsquare_nutrient_intake = 10
          when 'Fatty acids, total polyunsaturated'
            mealsquare_nutrient_intake = 4
          when 'Fatty acids, total saturated'
            mealsquare_nutrient_intake = 4 
          when 'Fatty acids, total trans'
            mealsquare_nutrient_intake = 0 
          when 'Cholesterol'
            mealsquare_nutrient_intake = 60
          when 'Carbohydrate, by difference'
            mealsquare_nutrient_intake = 36
          when 'Protein'
            mealsquare_nutrient_intake = 20
          when 'Vitamin K (phylloquinone)', 'Vitamin B-12',
            mealsquare_nutrient_intake = convert_percent_intake_to_raw_num(
              30, 
              record,
              symbolized_nutrient_name(record),            
              consumer.to_sym
            ) 
          when 'Vitamin D', 'Vitamin C, total ascorbic acid'
            mealsquare_nutrient_intake = convert_percent_intake_to_raw_num(
              50,
              record,
              symbolized_nutrient_name(record),
              consumer.to_sym
            )
          when 'Pantothenic Acid'
            mealsquare_nutrient_intake = convert_percent_intake_to_raw_num(
              45,
              record,
              symbolized_nutrient_name(record),
              consumer.to_sym
            )
          when 'Magnesium, Mg'
            mealsquare_nutrient_intake = convert_percent_intake_to_raw_num(
              35,
              record,
              symbolized_nutrient_name(record),
              consumer.to_sym
            )
          when 'Zinc, Zn', 'Copper, Cu'
            mealsquare_nutrient_intake = convert_percent_intake_to_raw_num(
              25,
              record,
              symbolized_nutrient_name(record),
              consumer.to_sym
            )
          end 
        end 
      end 
      if soylent_nutrient_intake.nil?
        soylent_nutrient_intake = 0
      end 
      if mealsquare_nutrient_intake.nil?
        mealsquare_nutrient_intake = 0
      end 
      (record['amt_consumed'].to_f + soylent_nutrient_intake + mealsquare_nutrient_intake).to_f.round(2)
    end 

    def nutrient_name(record)
      record['name']
    end

    def symbolized_nutrient_name(record)
      record['name'].to_sym
    end 

    private

    def adjust_RDA_for_weight(weight_in_lbs, rda)
      rda * weight_in_lbs/2.2    
    end 

    def convert_percent_intake_to_raw_num(percent_of_rda, record, nutrient_name_symbol, consumer_symbol)
      daily_rda(nutrient_name_symbol, consumer_symbol) * (percent_of_rda.to_f/100)
    end 

    def create_goal_hash(unit, mick_daily_rda, adia_daily_rda, upper_limit='N/A')
      {
        unit: unit,
        amount: {
          Mick: mick_daily_rda,
          Adia: adia_daily_rda
        },
        UL: upper_limit 
      }
    end 
  end 
end 
