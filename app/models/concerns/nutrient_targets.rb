module NutrientTargets
  extend ActiveSupport::Concern

  module ClassMethods
    def nutrient_target_hash
      {
        create_goal_hash('Iron, Fe', 'mg', 8, 18)
      }
    end 

    private

    def create_goal_hash(nutrient_name, unit, mick_daily_goal, adia_daily_goal)
      nutrient_name: {
        unit: unit,
        day: {
          Mick: mick_daily_goal,
          Adia: adia_daily_goal
        },
        week: {
          Mick: mick_daily_goal * 7,
          Adia: adia_daily_goal * 7
        }
      }
    end 
  end 
end 
