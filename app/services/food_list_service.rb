class FoodListService
  def initialize(search_term)
    @search_term = search_term
  end

  def search_results
    search_food_database.dig('list', 'items')
  end

  def ingredient_attributes
    location = Location.find_by(name: 'unknown')
    search_results.each_with_object([]) do |food, ingredient_attributes|
      ingredient_attributes << { ndbno: food['ndbno'], name: food['name'], location_id: location.id }
    end
  end

  private

  def search_food_database
    key = ENV['NDB_USDA_API_KEY']
    uri = URI("http://api.nal.usda.gov/ndb/search/?q=#{@search_term}&api_key=#{key}&format=json")
    JSON.parse(Net::HTTP.get(uri))
  end
end
