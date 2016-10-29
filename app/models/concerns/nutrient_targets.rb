module NutrientTargets
  extend ActiveSupport::Concern 

  module ClassMethods
    def percent_rda(intake, rda)
      (rda.present?) ? ((intake/rda * 100).round(2)) : ''
    end 

    def total_nutrient_intake(record, mealsquare_nutrition, soylent_nutrition)
      from_soylent = nutrients_from_food_table(soylent_nutrition, record)
      from_mealsquare = nutrients_from_food_table(mealsquare_nutrition, record)

      (record['amt_consumed'].to_f + from_soylent + from_mealsquare).round(2)
    end 

    def nutrient_name(record)
      record['name']
    end

    def symbolized_nutrient_name(record)
      record['name'].to_sym
    end 

    private

    def nutrients_from_food_table(food_nutrients, record)
      if food_nutrients.present?
        from_food = food_nutrients[record['name']]
        if from_food.present?
          return from_food
        else
          return 0
        end 
      else
        return 0
      end 
    end 
  end 
end 
