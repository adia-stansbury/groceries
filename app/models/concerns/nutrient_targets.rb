module NutrientTargets
  extend ActiveSupport::Concern

  module ClassMethods
    def nutrient_target_hash
      nutrient_targets = {
        Iron: {
          unit: 'mg/d',
          Mick: 8,
          Adia: 15
        }
      }
    end 
  end 
end 
