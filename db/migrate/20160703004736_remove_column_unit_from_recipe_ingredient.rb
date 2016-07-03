class RemoveColumnUnitFromRecipeIngredient < ActiveRecord::Migration
  def change
    remove_column :recipe_ingredients, :unit, :string
  end
end
