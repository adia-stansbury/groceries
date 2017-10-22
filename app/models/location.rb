class Location < ActiveRecord::Base
  has_many :ingredients
  has_many :recipe_ingredients, through: :ingredients, dependent: :destroy

  validates :name, uniqueness: true, presence: true

  before_save StripUserInputCallback.new(['name'])
end
