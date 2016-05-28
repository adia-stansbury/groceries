class AddColumnAmountInGramsToRecipeIngredient < ActiveRecord::Migration
  def change
    add_column :recipe_ingredients, :amount_in_grams, :real
  end
end
