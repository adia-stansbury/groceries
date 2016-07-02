namespace :units do
  desc "import unit names from recipe_ingredient table"
  task import_names: :environment do
    ActiveRecord::Base.transaction do 
      RecipeIngredient.all.uniq.pluck(:unit).each do |unit|
        Unit.create(name: unit)
      end 
    end 
  end
  desc "populate unit table from unit dev db"
  task populate_unit: :environment do 
    ActiveRecord::Base.transaction do 
      ["container", "ml", "tsp", "tbsp", "bag", "clove", "slices", "medium", "stalk", "strips", "tubs", "cup", "lb", "can", "envelope", "bunch", "oz", "package", "bottles", "fruit", "small", "jar"].each do |unit|
        Unit.create(name: unit)
      end 
    end 
  end 
end
