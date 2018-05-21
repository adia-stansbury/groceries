class Nutrition::IngredientQuery < Nutrition::BaseQuery
  private

  def subclass_join
    " JOIN ingredients
    ON ingredients.id = ingredient_nutrients.ingredient_id"
  end

  def subclass_where
    " WHERE ingredient_nutrients.ingredient_id IN (#{@food.id})"
  end

  def amount_consumed
    "sum((value/100)*100)"
  end
end
