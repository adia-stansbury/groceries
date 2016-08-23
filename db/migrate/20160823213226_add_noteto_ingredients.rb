class AddNotetoIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :note, :text
  end
end
