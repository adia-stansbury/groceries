module StoreDataInHash
  extend ActiveSupport::Concern

  module ClassMethods
    def name_id_pairs
      pluck(:name, :id).to_h
    end 
  end 
end 
