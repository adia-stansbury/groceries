module NutrientTargets
  extend ActiveSupport::Concern

  module ClassMethods
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
        'Alanine': create_goal_hash
        'Arginine': create_goal_hash
        'Aspartic acid': create_goal_hash
        'Cystine': create_goal_hash
        'Glutamic acid': create_goal_hash
        'Glycine': create_goal_hash
        'Histidine': create_goal_hash
        'Isoleucine': create_goal_hash
        'Leucine': create_goal_hash
        'Methionine': create_goal_hash
        'Phenylalanine': create_goal_hash
        'Proline': create_goal_hash
        'Serine': create_goal_hash
        'Threonine': create_goal_hash
        'Tryptophan': create_goal_hash
        'Tyrosine': create_goal_hash
        'Valine': create_goal_hash
        'Betaine': create_goal_hash
        'Carotene, alpha': create_goal_hash
        'Carotene, beta': create_goal_hash
        'Choline, total': create_goal_hash
        'Folate, DFE': create_goal_hash
        'Folate, food': create_goal_hash
        'Folate, total': create_goal_hash
        'Folic acid': create_goal_hash
        'Lutein + zeaxanthin': create_goal_hash
        'Lycopene': create_goal_hash
        'Niacin': create_goal_hash
        'Pantothenic acid': create_goal_hash
        'Retinol': create_goal_hash
        'Riboflavin': create_goal_hash
        'Thiamin': create_goal_hash
        'Vitamin A, IU': create_goal_hash
        'Vitamin A, RAE': create_goal_hash
        'Vitamin B-12': create_goal_hash
        'Vitamin B-6': create_goal_hash
        'Vitamin C, total ascorbic acid': create_goal_hash
        'Vitamin D': create_goal_hash
        'Vitamin D (D2 + D3)': create_goal_hash
        'Vitamin E (alpha-tocopherol)': create_goal_hash
        'Vitamin K (phylloquinone)': create_goal_hash
      }
    end 

    private

    def create_goal_hash(unit, mick_daily_goal, adia_daily_goal)
      {
        unit: unit,
        amount: {
          Mick: mick_daily_goal,
          Adia: adia_daily_goal
        },
      }
    end 
  end 
end 
