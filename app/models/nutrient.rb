class Nutrient < ActiveRecord::Base
  include CleanUpUserInput

  has_many :ingredient_nutrients, dependent: :destroy
  has_many :ingredients, through: :ingredient_nutrients
  has_many :consumer_nutrients, dependent: :destroy
  has_many :consumers, through: :consumer_nutrients
  has_many :food_nutrients, dependent: :destroy
  has_many :foods, through: :food_nutrients
  belongs_to :nutrient_group
  belongs_to :unit

  validates :name, uniqueness: true, presence: true

  def self.name_id_dictionary
    pluck(:name, :id).to_h
  end

  def self.nutrient_name(record)
    record['name']
  end

  def self.upper_limit_hash
    where.not(upper_limit: nil).pluck(:name, :upper_limit).to_h
  end

  def self.upper_limit(nutrients_upper_limit, nutrient_name)
    nutrients_upper_limit[nutrient_name]
  end

  def self.weekly_upper_limit(upper_limit)
    upper_limit.present? ? (upper_limit * 7) : ''
  end
end
