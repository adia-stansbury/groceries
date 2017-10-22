class FoodSource < ActiveRecord::Base
  has_many :ingredients

  validates :name, uniqueness: true, presence: true

  before_save StripUserInputCallback.new(['name'])
end
