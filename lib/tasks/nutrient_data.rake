namespace :nutrient_data do
  ndb_usda_api_key = ENV['NDB_USDA_API_KEY']
  desc "import nutrients" 
  task import_nutrient_names: :environment do
    HTTParty.get(
      "http://api.nal.usda.gov/ndb/list?format=json&lt=n&max=1500&api_key=#{ndb_usda_api_key}"
    )['list']['item'].each { |nutrient| Nutrient.create(name: nutrient['name']) }
  end 
  desc "import api response data to IngredientNutrient"
  task import_ingredient_nutrient: :environment do
    Ingredient.where.not(ndbno: nil).each do |ingredient|
      ndbno = ingredient.ndbno
      HTTParty.get(
        "http://api.nal.usda.gov/ndb/reports/?ndbno=#{ndbno}&type=f&format=json&api_key=#{ndb_usda_api_key}"
      )['report']['food']['nutrients'].each do |nutrient|
        ingredient_nutrition = IngredientNutrient.new
        ingredient_nutrition.ingredient_id = ingredient.id
        ingredient_nutrition.nutrient_id = Nutrient.where(
          name: nutrient['name']
        ).first.id
        ingredient_nutrition.value = nutrient['value']
        ingredient_nutrition.unit = nutrient['unit']
        ingredient_nutrition.save
      end 
    end 
  end
  desc "import nutrient groups" 
  task import_nutrient_groups: :environment do
    ndbno = '09038'
    HTTParty.get(
      "http://api.nal.usda.gov/ndb/reports/?ndbno=#{ndbno}&type=f&format=json&api_key=#{ndb_usda_api_key}"
    )['report']['food']['nutrients'].each do |nutrient| 
      NutrientGroup.create(name: nutrient['group']) 
    end 
  end 
  desc "link group to nutrient" 
  task match_group_to_nutrient: :environment do
    ndbno = '09038'
    response = HTTParty.get(
      "http://api.nal.usda.gov/ndb/reports/?ndbno=#{ndbno}&type=f&format=json&api_key=#{ndb_usda_api_key}"
    )['report']['food']['nutrients']
    Nutrient.all.each do |nutrient|
      response.each do |info| 
        if info['name'] == nutrient.name 
          group_id = NutrientGroup.where(name: info['group']).first.id
          nutrient.group_id = group_id
          nutrient.save
        end 
      end 
    end 
  end
end
