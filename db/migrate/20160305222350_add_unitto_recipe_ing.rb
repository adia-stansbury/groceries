class AddUnittoRecipeIng < ActiveRecord::Migration
  def up
    add_column :recipe_ingredients, :unit, :string
    add_column :recipe_ingredients, :quantity, :integer

    RecipeIngredient.all.each do |row|
      row.quantity = row.amount.split(' ').first.to_i
      unit = row.amount.split(' ')[1]
      if unit.nil?
        row.unit = ' '
      else
        row.unit = unit.to_s
      end 
      row.save
    end

    remove_column :recipe_ingredients, :amount, :string
  end 

  def down
    add_column :recipe_ingredients, :amount, :string

    RecipeIngredient.all.each do |row|
      row.amount = row.quantity.to_s + ' ' + row.unit.to_s
      row.save
    end

    remove_column :recipe_ingredients, :unit, :string
    remove_column :recipe_ingredients, :quantity, :integer
  end
end
