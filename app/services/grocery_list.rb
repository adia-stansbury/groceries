class GroceryList
  def initialize(sql_meal_plan_ids)
    @sql_meal_plan_ids = sql_meal_plan_ids
  end

  def create
    body = ''
    items.each do |row|
      font_weight = row['is_for_first_day'] ? 'strong' : 'regular'
      body += "<en-todo/><#{font_weight}>#{row['total_quantity']} #{row['unit']} #{row['name']}</#{font_weight}> <i>(#{row['recipe_names']})</i><br/>"
    end

    body
  end

  private

  def items
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
