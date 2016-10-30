module CleanUpUserInput
  extend ActiveSupport::Concern

  included do
    before_save :remove_extraneous_characters
  end 

  private

  def remove_extraneous_characters
    name.chomp!
    name.strip!
    if self.try(:ndbno).present?
      ndbno.chomp!
      ndbno.strip!
    end 
  end 
end 
