module NutrientTargets
  extend ActiveSupport::Concern

  module ClassMethods
    ADIA_WEIGHT_LBS = 122
    MICK_WEIGHT_LBS = 201

    def nutrient_target_hash
      {
        'Calcium, Ca': create_goal_hash('mg', 1000, 1000),
        'Copper, Cu': create_goal_hash('ug', 900, 900),
        'Iron, Fe': create_goal_hash('mg', 8, 18),
        'Magnesium, Mg': create_goal_hash('mg', 420, 310),
        'Manganese, Mn': create_goal_hash('mg', 2.3, 1.8),
        'Phosphorus, P': create_goal_hash('mg', 700, 700),
        'Potassium, K': create_goal_hash('g', 4.7, 4.7),
        'Selenium, Se': create_goal_hash('ug', 55, 55),
        'Sodium, Na': create_goal_hash('g', 1.5, 1.5),
        'Zinc, Zn': create_goal_hash('mg', 11, 8),
        'Fiber, total dietary': create_goal_hash('g', 38, 25),
        'Protein': create_goal_hash('g', 56, 46),
        'Alanine': create_goal_hash('no RDA', '', ''),
        'Arginine': create_goal_hash('no RDA', '', ''),
        'Aspartic acid': create_goal_hash('no RDA', '', ''),
        'Cystine': create_goal_hash(
          'mg',
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 19),
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 19)
        ),
        'Glutamic acid': create_goal_hash('no RDA', '', ''),
        'Glycine': create_goal_hash('no RDA', '', ''),
        'Histidine': create_goal_hash(
          'mg', 
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 14), 
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 14)
        ),
        'Isoleucine': create_goal_hash(
          'mg',
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 19),
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 19)
        ),
        'Leucine': create_goal_hash(
          'mg',
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 42),
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 42)
        ),
        'Lysine': create_goal_hash(
          'mg',
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 38),
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 38)
        ),
        'Methionine': create_goal_hash(
          'mg',
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 19),
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 19)
        ),
        'Phenylalanine': create_goal_hash(
          'mg',
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 33),
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 33)
        ),
        'Proline': create_goal_hash('no RDA', '', ''),
        'Serine': create_goal_hash('no RDA', '', ''),
        'Threonine': create_goal_hash(
          'mg',
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 20),
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 20)
        ),
        'Tryptophan': create_goal_hash(
          'mg',
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 5),
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 5)
        ),
        'Tyrosine': create_goal_hash(
          'mg',
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 33),
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 33)
        ),
        'Valine': create_goal_hash(
          'mg',
          adjust_RDA_for_weight(MICK_WEIGHT_LBS, 24),
          adjust_RDA_for_weight(ADIA_WEIGHT_LBS, 24)
        ),
        'Betaine': create_goal_hash('no RDA', '', ''),
        'Carotene, alpha': create_goal_hash('no RDA', '', ''),
        'Carotene, beta': create_goal_hash('no RDA', '', ''),
        'Choline, total': create_goal_hash('mg', 550, 425), 
        'Folate, DFE': create_goal_hash('ug', 400, 400),
        'Folate, food': create_goal_hash('ug', 400, 400),
        'Folate, total': create_goal_hash('ug', 400, 400),
        'Folic acid': create_goal_hash('no RDA', '', ''),
        'Lutein + zeaxanthin': create_goal_hash('no RDA', '', ''),
        'Lycopene': create_goal_hash('no RDA', '', ''),
        'Niacin': create_goal_hash('mg', 14, 14), 
        'Pantothenic acid': create_goal_hash('mg', 5, 5), 
        'Retinol': create_goal_hash('no RDA', '', ''),
        'Riboflavin': create_goal_hash('mg', 1.1, 1.1),
        'Thiamin': create_goal_hash('mg', 1.2, 1.1),
        'Vitamin A, IU': create_goal_hash('no RDA', '', ''),
        'Vitamin A, RAE': create_goal_hash('ug', 900, 700),
        'Vitamin B-12': create_goal_hash('ug', 2.4, 2.4), 
        'Vitamin B-6': create_goal_hash('mg', 1.3, 1.3), 
        'Vitamin C, total ascorbic acid': create_goal_hash('mg', 90, 75),
        'Vitamin D': create_goal_hash('ug', 5, 5),
        'Vitamin D (D2 + D3)': create_goal_hash('no RDA', '', ''),
        'Vitamin E (alpha-tocopherol)': create_goal_hash('mg', 15, 15),
        'Vitamin K (phylloquinone)': create_goal_hash('ug', 120, 90) 
      }
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
