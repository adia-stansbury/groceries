class Nutrition::MealPlanQuery < Nutrition::BaseQuery
  private

  def subclass_join
    super +
    " JOIN meal_plan_recipes
    ON recipe_ingredients.recipe_id = meal_plan_recipes.recipe_id"
  end

  def subclass_where
    " WHERE meal_plan_recipes.meal_plan_id = (#{@food.id})
    AND meal_plan_recipes.date
    BETWEEN CAST('#{@food.dates.first}' AS date)
    AND CAST('#{@food.dates.last}' AS date)"
  end
end
