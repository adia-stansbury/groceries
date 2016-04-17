namespace :nutrient_data do
  ndb_usda_api_key = ENV['NDB_USDA_API_KEY']
  desc "import nutrient names to nutrient table from nutrient api"
  task import_nutrient_names: :environment do
    HTTParty.get(
      "http://api.nal.usda.gov/ndb/list?format=json&lt=n&api_key=#{ndb_usda_api_key}"
    )['list']['item'].each { |nutrient| Nutrient.create(name: nutrient['name']) }
  end 
  desc "import api response data to IngredientNutrient"
  task import_ingredient_nutrient: :environment do
    Ingredient.where.not(ndbno: nil).each do |ingredient|
      ndbno = ingredient.ndbno
      response = HTTParty.get("http://api.nal.usda.gov/ndb/reports/?ndbno=#{ndbno}&type=f&format=json&api_key=#{ndb_usda_api_key}")
      response['report']['food']['nutrients'].each do |nutrient|
        ingredient_nutrition = IngredientNutrient.new
        ingredient_nutrition.ingredient_id = ingredient.id
        nutrient_id = Nutrient.where(name: nutrient['name']).first.id
        ingredient_nutrition.nutrient_id = nutrient_id
        ingredient_nutrition.value = nutrient['value']
        ingredient_nutrition.unit = nutrient['unit']
      end 
    end 
  end
end
