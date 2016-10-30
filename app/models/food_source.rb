class FoodSource < ActiveRecord::Base
  include CleanUpUserInput

  has_many :ingredients

  validates :name, uniqueness: true, presence: true
end 
