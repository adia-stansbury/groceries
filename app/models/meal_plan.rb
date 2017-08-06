class MealPlan < ActiveRecord::Base
  has_many :meal_plan_recipes, dependent: :destroy
  has_many :recipes, through: :meal_plan_recipes
  has_many :meal_plan_recipe_days, through: :meal_plan_recipes
  belongs_to :consumer

  def self.shopping_list(sql_meal_plan_ids)
    RecipeIngredient.connection.select_all(
      "SELECT SUM(quantity*meal_plan_recipes.number_of_recipes) AS total_quantity, units.name AS unit, ingredients.name, STRING_AGG(distinct(recipes.name), '; ') AS recipe_names
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
        WHERE meal_plan_recipes.meal_plan_id IN (#{sql_meal_plan_ids})
        GROUP BY locations.ordering, ingredients.name, units.name
        ORDER BY locations.ordering
      "
    )
  end

  def self.fetch_info_from_calendar(calendar_events_items, start_date)
    mealplan = {}
    mealplan_dates = {}
    calendar_events_items.each do |event|
      recipe = event.summary
      recipe_date = event.start.date.to_date
      is_for_first_day = MealPlanRecipe.is_first_day_recipe(recipe_date, start_date)

      if mealplan.has_key?(recipe)
        mealplan[recipe][:number_of_recipes] += 1
        mealplan_dates[recipe][:dates] << recipe_date
      else
        mealplan[recipe] = {}
        mealplan[recipe][:first_day_recipe] = is_for_first_day
        mealplan[recipe][:number_of_recipes] = 1
        mealplan_dates[recipe] = {}
        mealplan_dates[recipe][:dates] = []
        mealplan_dates[recipe][:dates] << recipe_date
      end
    end

    { mealplan: mealplan, mealplan_dates: mealplan_dates }

  end

  def self.fetch_mealplan_info_sans_dates(all_mealplan_info)
    all_mealplan_info[:mealplan]
  end

  def self.add_recipe_ids_to_build(mealplan)
    mealplan.keys.map do |recipe_name|
      # TODO refactor to not hit db in loop: use hash of recipe names & ids
      # TODO refactor to replace name with id
      mealplan[recipe_name][:recipe_id] = Recipe.where(name: recipe_name).first.id
    end
    mealplan
  end

  def dates
    meal_plan_recipe_days.order(:date).pluck(:date)
  end

  def nutrient_intake(start_date, end_date)
    IngredientNutrient.connection.select_all(
      "SELECT nutrients.id, nutrients.name, ingredient_nutrients.unit AS amt_consumed_unit, sum((value/100)*amount_in_grams*meal_plan_recipes.number_of_recipes) AS amt_consumed
        FROM ingredient_nutrients
        JOIN recipe_ingredients
        ON recipe_ingredients.ingredient_id = ingredient_nutrients.ingredient_id
        JOIN nutrients
        ON nutrients.id = ingredient_nutrients.nutrient_id
        JOIN meal_plan_recipes
        ON recipe_ingredients.recipe_id = meal_plan_recipes.recipe_id
        JOIN meal_plan_recipe_days
        ON meal_plan_recipes.id = meal_plan_recipe_days.meal_plan_recipe_id
        WHERE meal_plan_recipes.meal_plan_id = (#{id})
        AND meal_plan_recipe_days.date
        BETWEEN CAST('#{start_date}' AS date) AND CAST('#{end_date}' AS date)
        GROUP BY nutrients.id, nutrients.name, amt_consumed_unit
        ORDER BY nutrients.name
      "
    )
  end

  def nutrient_intake_from_custom_food(food, nutrient_name)
    if recipes.pluck(:name).include?(food.name)
      if food.nutrition[nutrient_name].present?
        return food.nutrition[nutrient_name]
      else
        return 0
      end
    else
      return 0
    end
  end
end
