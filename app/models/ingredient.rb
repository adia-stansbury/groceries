class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients
  has_many :ingredient_nutrients, dependent: :destroy
  belongs_to :location
  belongs_to :food_source
  belongs_to :unit

  validates :name, uniqueness: true, presence: true
  validates :location_id, presence: true

  before_save :remove_extraneous_characters
  after_save :create_ingredient_nutrient_record
  
  private

  def remove_extraneous_characters
    name.chomp!
    name.strip!
    ndbno.chomp!
    ndbno.strip!
  end 

  def create_ingredient_nutrient_record
    if self.ndbno.present?
      self.ndbno.chomp!
      self.ndbno.strip!
      ndb_usda_api_key = ENV['NDB_USDA_API_KEY']
      ndbno = self.ndbno
      HTTParty.get(
        "http://api.nal.usda.gov/ndb/reports/?ndbno=#{ndbno}&type=f&format=json&api_key=#{ndb_usda_api_key}"
      )['report']['food']['nutrients'].each do |nutrient|
        ingredient_nutrition = IngredientNutrient.new
        ingredient_nutrition.ingredient_id = self.id
        ingredient_nutrition.nutrient_id = Nutrient.where(
          name: nutrient['name']
        ).first.id
        ingredient_nutrition.value = nutrient['value']
        ingredient_nutrition.unit = nutrient['unit']
        ingredient_nutrition.save
      end 
    end 
  end 
end 
