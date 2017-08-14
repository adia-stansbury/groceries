class RequireMealPlanToHaveConsumer < ActiveRecord::Migration[5.0]
  def change
    change_column_null :meal_plans, :consumer_id, false
  end
end
