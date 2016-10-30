class ConsumerNutrient < ActiveRecord::Base 
  validates :nutrient_id, presence: true
  validates :consumer_id, presence: true, uniqueness: { 
    scope: :nutrient_id,
    message: 'Nutrient_id and consumer_id combo must be unique' 
  }
  validates :daily_rda, presence: true

  belongs_to :nutrient
  belongs_to :consumer

  def self.daily_rda(nutrient_name, consumer_rdas)
    consumer_rdas[nutrient_name]
  end 

  def self.weekly_rda(daily_rda)
    daily_rda.present? ? (daily_rda * 7).to_f.round(2) : ''
  end 
end 
