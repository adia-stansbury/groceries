class NutrientGroup < ActiveRecord::Base
  include CleanUpUserInput

  has_many :nutrients

  validates :name, uniqueness: true, presence: true
end 
