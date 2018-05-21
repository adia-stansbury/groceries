class Nutrition::BaseQuery
  def initialize(food)
    @food = food
  end

  def nutrition
    IngredientNutrient.connection.select_all(
      "SELECT
        nutrients.id,
        nutrients.name,
        nutrients.upper_limit,
        ingredient_nutrients.unit AS amt_consumed_unit," +
        subclass_select +
      " FROM ingredient_nutrients" +
      subclass_join +
      " JOIN nutrients
      ON nutrients.id = ingredient_nutrients.nutrient_id
      JOIN consumer_nutrients
      ON consumer_nutrients.nutrient_id = ingredient_nutrients.nutrient_id
      AND consumer_nutrients.consumer_id = #{consumer.id}" +
      subclass_where +
      " GROUP BY nutrients.id, nutrients.name, amt_consumed_unit, consumer_nutrients.daily_rda
      ORDER BY nutrients.name"
    )
  end

  private

  def consumer
    Consumer.find_by(name: 'Adia')
  end

  def subclass_select
    "#{amount_consumed} AS amt_consumed,
    (#{amount_consumed}/(consumer_nutrients.daily_rda * #{number_of_days}) * 100) AS percent_rda"
  end

  def subclass_join
    " JOIN recipe_ingredients
    ON recipe_ingredients.ingredient_id = ingredient_nutrients.ingredient_id"
  end

  def subclass_where
    raise NotImplementedError, "Implement #subclass_where in each subclass"
  end

  def amount_consumed
    "sum((value/100)*recipe_ingredients.amount_in_grams)"
  end

  def number_of_days
    1
  end
end
