class AddUnittoRecipeIng < ActiveRecord::Migration
  def up
    add_column :recipe_ingredients, :unit, :string
    add_column :recipe_ingredients, :quantity, :integer

    RecipeIngredient.all.each do |row|
      row.quantity = row.amount.split(' ').first.to_i
      row.unit = row.amount.split(' ').last
      row.save
    end

    remove_column :recipe_ingredients, :amount, :string
  end 

  def down
    add_column :recipe_ingredients, :amount, :string

    RecipeIngredient.all.each do |row|
      row.amount = row.quantity.to_s + ' ' + row.unit
      row.save
    end

    remove_column :recipe_ingredients, :unit, :string
    remove_column :recipe_ingredients, :quantity, :integer
  end
end
