class ChangeRecipeIngredientsQuantityDataType < ActiveRecord::Migration
  def change
    change_column :recipe_ingredients, :quantity, 'real USING CAST(quantity AS real)' 
  end
end
