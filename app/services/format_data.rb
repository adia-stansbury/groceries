module FormatData
  def self.to_ingredient_nutrient_rows(nutrition, dictionary)
    new_rows = []
    nutrition.each do |nutrient|
      new_rows << {
        nutrient_id: dictionary[nutrient['name']],
        value: nutrient['value'],
        unit: nutrient['unit']
      }
    end
    new_rows
  end
end
