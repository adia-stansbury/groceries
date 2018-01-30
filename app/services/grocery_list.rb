class GroceryList
  def initialize(sql_meal_plan_ids)
    @sql_meal_plan_ids = sql_meal_plan_ids
  end

  def create
    RecipeIngredient.connection.select_all(
      "SELECT
          SUM(quantity) AS total_quantity,
          MIN(meal_plan_recipes.date) = (SELECT MIN(meal_plan_recipes.date) FROM meal_plan_recipes WHERE meal_plan_recipes.meal_plan_id IN(#{@sql_meal_plan_ids})) AS is_for_first_day,
          units.name AS unit,
          ingredients.name,
          STRING_AGG(distinct(recipes.name), '; ') AS recipe_names
        FROM recipe_ingredients
        JOIN recipes
        ON recipe_ingredients.recipe_id = recipes.id
        JOIN ingredients
        ON recipe_ingredients.ingredient_id = ingredients.id
        JOIN locations
        ON ingredients.location_id = locations.id
        JOIN units
        ON recipe_ingredients.unit_id = units.id
        JOIN meal_plan_recipes
        ON recipe_ingredients.recipe_id = meal_plan_recipes.recipe_id
        WHERE meal_plan_recipes.meal_plan_id IN (#{@sql_meal_plan_ids})
        GROUP BY locations.ordering, ingredients.name, units.name
        ORDER BY locations.ordering
      "
    )
  end
end
