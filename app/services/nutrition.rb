# TODO: move this to be part of Ingredient model
module Nutrition
  def self.for_ingredient(ingredient)
    ndbno = ingredient&.ndbno
    if ndbno
      key = ENV['NDB_USDA_API_KEY']
      uri = URI("http://api.nal.usda.gov/ndb/reports/?ndbno=#{ndbno}&type=f&format=json&api_key=#{key}")
      response = JSON.parse(Net::HTTP.get(uri))
      response['report']['food']['nutrients']
    else
      {}
    end
  end
end
