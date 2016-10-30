module Fetcher
  extend ActiveSupport::Concern

  module ClassMethods
    def fetch_id_from_name(name)
      where(name: name).first.id
    end 
  end 
end 
