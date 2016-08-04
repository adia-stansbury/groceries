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
        'Zinc, Zn': create_goal_hash('mg', 11, 8)
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
