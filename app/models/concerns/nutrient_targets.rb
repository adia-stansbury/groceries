module NutrientTargets
  extend ActiveSupport::Concern

  module ClassMethods
    def nutrient_target_hash
      {
        'Iron, Fe': create_goal_hash('mg', 8, 18)
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
