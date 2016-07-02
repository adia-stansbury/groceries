namespace :units do
  desc 'import unit names from recipe_ingredient table'
  task import_names: :environment do
    ActiveRecord::Base.transaction do 
      RecipeIngredient.all.uniq.pluck(:unit).each do |unit|
        Unit.create(name: unit)
      end 
    end 
  end
  desc 'populate unit table from unit dev db'
  task populate_unit: :environment do 
    ActiveRecord::Base.transaction do 
      ["container", "ml", "tsp", "tbsp", "bag", "clove", "slices", "medium", "stalk", "strips", "tubs", "cup", "lb", "can", "envelope", "bunch", "oz", "package", "bottles", "fruit", "small", "jar"].each do |unit|
        Unit.create(name: unit)
      end 
    end 
  end 
  desc 'use recipe_ingredient.unit to populate unit_id'
  task populate_unit_id: :environment do
    RecipeIngredient.all.each do |record|
      unit = record[:unit]
      case unit
      when 'bags'
        unit = 'bag'
      when 'cups'
       unit = 'cup'
      when 'tbsps'
        unit = 'tbsp'
      when 'cloves'
        unit = 'clove'
      when 'cups'
        unit = 'cup'
      when 'fruits'
        unit = 'fruit'
      when 'stalks'
        unit = 'stalk'
      when 'cans'
        unit = 'can'
      when ' tbsp'
        unit = 'tbsp'
      when ' fruits'
        unit = 'fruit'
      when 'rashers'
        unit = 'slices'
      when 'lbs'
        unit = 'lb'
      end 
      if Unit.all.pluck(:name).include?(unit)
        record.unit_id = Unit.where(name: unit).first.id
        record.save
      end 
    end 
  end 
  desc 'prod db unit values imported to unit_id'
  task import_unit_values: :environment do
    RecipeIngredient.all.each do |record|
      unit = record[:unit]
      if unit == 'each' || unit == 'hen' || unit == 'large' || unit == ' egg'
        record.unit_id = 23
        record.save
        next
      end 
      case unit
      when 'cups '
        unit = 'cup'
      when 'leaves'
        unit = 'bunch'
      when 'box'
        unit = 'container'
      end 
      if Unit.all.pluck(:name).include?(unit)
        record.unit_id = Unit.where(name: unit).first.id
        record.save
      end 
    end 
  end 
end
