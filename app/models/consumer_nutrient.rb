# TODO: Rename to make it clear that this is only for nutrients with RDA
class ConsumerNutrient < ActiveRecord::Base
  validates :nutrient_id, presence: true
  validates :consumer_id, presence: true, uniqueness: {
    scope: :nutrient_id,
    message: 'Nutrient_id and consumer_id combo must be unique'
  }
  validates :daily_rda, presence: true

  belongs_to :nutrient
  belongs_to :consumer

  def percent_rda(intake, number_of_days)
    (intake/(daily_rda * number_of_days) * 100).round(2)
  end
end
