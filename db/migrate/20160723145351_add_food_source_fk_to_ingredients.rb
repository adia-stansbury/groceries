class AddFoodSourceFkToIngredients < ActiveRecord::Migration
  def change
    add_reference :ingredients, :food_source, foreign_key: true
  end
end
