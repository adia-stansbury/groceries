class AddColumnServingsToRecipeIngredients < ActiveRecord::Migration
  def change
    add_column :recipes, :number_of_servings, :float
  end
end
