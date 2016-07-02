namespace :units do
  desc "import unit names from recipe_ingredient table"
  task import_names: :environment do
    ActiveRecord::Base.transaction do 
      RecipeIngredient.all.uniq.pluck(:unit).each do |unit|
        Unit.create(name: unit)
      end 
    end 
  end
end
