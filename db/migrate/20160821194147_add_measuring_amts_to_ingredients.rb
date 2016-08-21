class AddMeasuringAmtsToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :measuring_amount, :real
    add_column :ingredients, :num_of_grams_in_measuring_amount, :real
    add_reference :ingredients, :unit, foreign_key: true
  end
end
