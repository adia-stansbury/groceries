module Fetcher
  extend ActiveSupport::Concern

  module ClassMethods
    def fetch_id_from_name(ids, name)
      ids[name]
    end 
  end 
end 
