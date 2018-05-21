class Nutrition::RecipeQuery < Nutrition::BaseQuery
  private

  def subclass_where
    " WHERE recipe_ingredients.recipe_id IN (#{@food.id})"
  end
end
