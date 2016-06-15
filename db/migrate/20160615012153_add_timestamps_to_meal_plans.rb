class AddTimestampsToMealPlans < ActiveRecord::Migration
  def change
    add_column :meal_plans, :created_at, :datetime
  end
end
