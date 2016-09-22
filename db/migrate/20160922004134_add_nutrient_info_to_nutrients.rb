class AddNutrientInfoToNutrients < ActiveRecord::Migration
  def change
    add_column :nutrients, :upper_limit, :real
    add_reference :nutrients, :unit, index: true, foreign_key: true
  end
end
