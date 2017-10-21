module Nutrition
  def self.for_ingredient(ingredient)
    ndbno = ingredient.ndbno
    key = ENV['NDB_USDA_API_KEY']
    uri = URI(
      "http://api.nal.usda.gov/ndb/reports/?ndbno=#{ndbno}&type=f&format=json&api_key=#{key}"
    )
    response = JSON.parse(Net::HTTP.get(uri))
    response['report']['food']['nutrients']
  end
end
