class Consumer < ActiveRecord::Base
  has_many :meal_plans
  validates :name, uniqueness: true, presence: true
end 
