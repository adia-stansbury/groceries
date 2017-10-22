class Unit < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :ingredients
  has_many :nutrients

  validates :name, uniqueness: true, presence: true

  before_save StripUserInputCallback.new(['name'])
end
