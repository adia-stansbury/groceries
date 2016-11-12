class Ingredient < ActiveRecord::Base
  include CleanUpUserInput

  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients
  has_many :ingredient_nutrients, dependent: :destroy
  belongs_to :location
  belongs_to :food_source
  belongs_to :unit

  validates :name, uniqueness: true, presence: true
  validates :location_id, presence: true

  after_save :create_ingredient_nutrient_records
  
  private

  def create_ingredient_nutrient_records
    if ndbno.present?
      ndbno = format_ndbno
      new_rows = []
      nutrients = fetch_nutrients
      nutrition(ndbno, ENV['NDB_USDA_API_KEY']).each do |nutrient|
        nutrient_id = nutrient_id(nutrients, nutrient)
        new_rows << new_row(nutrient, nutrient_id)
      end 
      IngredientNutrient.create(new_rows)
    end 
  end 

  def new_row(nutrient, nutrient_id)
    {
      ingredient_id: id,
      nutrient_id: nutrient_id,
      value: nutrient['value'],
      unit: nutrient['unit']
    }
  end 

  def nutrient_id(nutrients, nutrient)
    nutrients[nutrient['name']]
  end 

  def fetch_nutrients
    Nutrient.pluck(:name, :id).to_h
  end 

  def nutrition(ndbno, key)
      HTTParty.get(
        "http://api.nal.usda.gov/ndb/reports/?ndbno=#{ndbno}&type=f&format=json&api_key=#{key}"
      )['report']['food']['nutrients']
  end 

  def format_ndbno
    ndbno.chomp!
    ndbno.strip!
    ndbno
  end 
end 
