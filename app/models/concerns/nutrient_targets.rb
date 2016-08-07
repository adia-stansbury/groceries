module NutrientTargets
  extend ActiveSupport::Concern

  module ClassMethods
    ADIA_WEIGHT_LBS = 122
    MICK_WEIGHT_LBS = 201

    def daily_rda_hash
      {
        'Calcium, Ca': create_goal_hash('mg', 1000, 1000),
        'Copper, Cu': create_goal_hash('mg', 0.9, 0.9),
        'Iron, Fe': create_goal_hash('mg', 8, 18),
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
        'Folate, DFE': create_goal_hash('ug', 400, 400),
        'Folate, food': create_goal_hash('ug', 400, 400),
        'Folate, total': create_goal_hash('ug', 400, 400),
        'Folic acid': create_goal_hash('no RDA', 0, 0),
        'Lutein + zeaxanthin': create_goal_hash('no RDA', 0, 0),
        'Lycopene': create_goal_hash('no RDA', 0, 0),
        'Niacin': create_goal_hash('mg', 14, 14), 
        'Pantothenic acid': create_goal_hash('mg', 5, 5), 
        'Retinol': create_goal_hash('no RDA', 0, 0),
        'Riboflavin': create_goal_hash('mg', 1.1, 1.1),
        'Thiamin': create_goal_hash('mg', 1.2, 1.1),
        'Vitamin A, IU': create_goal_hash('no RDA', 0, 0),
        'Vitamin A, RAE': create_goal_hash('ug', 900, 700),
        'Vitamin B-12': create_goal_hash('ug', 2.4, 2.4), 
        'Vitamin B-6': create_goal_hash('mg', 1.3, 1.3), 
        'Vitamin C, total ascorbic acid': create_goal_hash('mg', 90, 75),
        'Vitamin D': create_goal_hash('ug', 5, 5),
        'Vitamin D (D2 + D3)': create_goal_hash('no RDA', 0, 0),
        'Vitamin E (alpha-tocopherol)': create_goal_hash('mg', 15, 15),
        'Vitamin K (phylloquinone)': create_goal_hash('ug', 120, 90) 
      }
    end 

    def percent_rda(intake, rda)
      (intake.to_i.to_f/rda * 100).round(2)
    end 

    private

    def adjust_RDA_for_weight(weight_in_lbs, rda)
      rda * weight_in_lbs/2.2    
    end 

    def create_goal_hash(unit, mick_daily_rda, adia_daily_rda)
      {
        unit: unit,
        amount: {
          Mick: mick_daily_rda,
          Adia: adia_daily_rda
        },
      }
    end 
  end 
end 
