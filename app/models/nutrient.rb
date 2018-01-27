class Nutrient < ActiveRecord::Base
  has_many :ingredient_nutrients, dependent: :destroy
  has_many :ingredients, through: :ingredient_nutrients
  has_many :consumer_nutrients, dependent: :destroy
  has_many :consumers, through: :consumer_nutrients
  belongs_to :nutrient_group
  belongs_to :unit

  validates :name, uniqueness: true, presence: true

  before_save StripUserInputCallback.new(['name'])

  def self.name_id_dictionary
    pluck(:name, :id).to_h
  end
end
