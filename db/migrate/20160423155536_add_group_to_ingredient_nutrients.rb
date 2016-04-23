class AddGroupToIngredientNutrients < ActiveRecord::Migration
  def change
    add_column :ingredient_nutrients, :group, :string, null: false
  end
end
