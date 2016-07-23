class CreateFoodSources < ActiveRecord::Migration
  def change
    create_table :food_sources do |t|
      t.string :name, null: false, unique: true
    end
  end
end
