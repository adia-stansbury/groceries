class CreateFoodNutrients < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :name, null: false
    end 

    create_join_table :foods, :nutrients, table_name: :food_nutrients do |t|
      t.index :food_id
      t.index :nutrient_id
      t.float :nutrient_amount, null: false
    end
  end
end
