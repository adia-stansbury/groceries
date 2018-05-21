class ConsumerNutrient < ActiveRecord::Base
  validates :nutrient_id, presence: true
  validates :consumer_id, presence: true, uniqueness: {
    scope: :nutrient_id,
    message: 'Nutrient_id and consumer_id combo must be unique'
  }
  validates :daily_rda, presence: true

  belongs_to :nutrient
  belongs_to :consumer
end
