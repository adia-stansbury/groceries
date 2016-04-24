class CreateIngredientNutrients < ActiveRecord::Migration
  def change
    create_table :ingredient_nutrients do |t|
      t.string :value, null: false
      t.string :unit, null: false
      t.references :nutrient, index: true, foreign_key: true, null: false
      t.references :ingredient, index: true, foreign_key: true, null: false
    end
  end
end
