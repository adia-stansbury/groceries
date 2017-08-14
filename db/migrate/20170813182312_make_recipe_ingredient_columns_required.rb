class MakeRecipeIngredientColumnsRequired < ActiveRecord::Migration[5.0]
  def change
    change_column_null :recipe_ingredients, :recipe_id, false
    change_column_null :recipe_ingredients, :ingredient_id, false
  end
end
