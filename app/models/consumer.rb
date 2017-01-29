class Consumer < ActiveRecord::Base
  include CleanUpUserInput

  has_many :consumer_recipes, dependent: :destroy
  has_many :recipes, through: :consumer_recipes
  has_many :meal_plans, dependent: :destroy
  has_many :consumer_nutrients, dependent: :destroy
  has_many :nutrients, through: :consumer_nutrients

  validates :name, uniqueness: true, presence: true
  validates :weight_in_lbs, presence: true

  def rda_hash
    nutrients.pluck(:name, :daily_rda).to_h
  end
end
