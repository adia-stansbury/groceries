class NutrientGroup < ActiveRecord::Base
  has_many :nutrients

  validates :name, uniqueness: true, presence: true

  before_save :remove_extraneous_characters
  
  private

  def remove_extraneous_characters
    name.chomp!
    name.strip!
  end 
end 
