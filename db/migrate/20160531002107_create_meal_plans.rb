class CreateMealPlans < ActiveRecord::Migration
  def change
    create_table :meal_plans do |t|
      t.integer :consumer_id
      t.timestamp
    end
  end
end
