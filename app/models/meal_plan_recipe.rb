class ConsumerRecipe < ActiveRecord::Base
  belongs_to :consumer
  belongs_to :recipe
end 
