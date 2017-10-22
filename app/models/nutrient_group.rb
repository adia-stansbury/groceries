class NutrientGroup < ActiveRecord::Base
  has_many :nutrients

  validates :name, uniqueness: true, presence: true

  before_save StripUserInputCallback.new(['name'])
end
