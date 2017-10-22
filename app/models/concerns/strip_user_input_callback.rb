class StripUserInputCallback
  def initialize(attributes)
    @attributes = attributes
  end

  def before_save(record)
    @attributes.each do |attribute|
      value = record.send("#{attribute}")
      if value
        record.send("#{attribute}=", value.strip)
      end
    end
  end
end
