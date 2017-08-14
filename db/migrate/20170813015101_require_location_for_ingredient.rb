class RequireLocationForIngredient < ActiveRecord::Migration[5.0]
  def change
    change_column_null :ingredients, :location_id, false
    add_index :ingredients, :location_id
  end
end
