class AddColumnUnitIdToRecipeIngredients < ActiveRecord::Migration
  def change
    add_column :recipe_ingredients, :unit_id, :integer
    add_foreign_key :recipe_ingredients, :units
  end
end
