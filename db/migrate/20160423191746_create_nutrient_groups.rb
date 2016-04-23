class CreateNutrientGroups < ActiveRecord::Migration
  def change
    create_table :nutrient_groups do |t|
      t.string :name, nulll: false
    end
  end
end
