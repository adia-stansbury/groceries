class ChangeColumnIngredientNutrientsValueToReal < ActiveRecord::Migration
  def change
    change_column :ingredient_nutrients, :value, 'real USING CAST(value AS real)' 
  end
end
