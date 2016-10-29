class ConsumerNutrient < ActiveRecord::Base 
  validates :nutrient_id, presence: true
  validates :consumer_id, presence: true, uniqueness: { 
    scope: :nutrient_id,
    message: 'Nutrient_id and consumer_id combo must be unique' 
  }
  validates :daily_rda, presence: true

  belongs_to :nutrient
  belongs_to :consumer

  def self.daily_rda(nutrient_name, consumer_name)
    nutrient_id = Nutrient.fetch_id_from_name(nutrient_name)
    consumer_id = Consumer.fetch_id_from_name(consumer_name)
    self.where(nutrient_id: nutrient_id, consumer_id: consumer_id)
      .first.try(:daily_rda)
  end 

  def self.weekly_rda(daily_rda)
    daily_rda.present? ? (daily_rda * 7).to_f.round(2) : ''
  end 
end 
