class NutrientGroup < ActiveRecord::Base
  has_many :nutrients

  validates :name, uniqueness: true, presence: true
end 
