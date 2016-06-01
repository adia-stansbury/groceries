class CreateConsumerRecipes < ActiveRecord::Migration
  def change
    create_table :consumer_recipes do |t|
      t.integer :consumer_id, null: false
      t.integer :recipe_id, null: false
    end
  end
end
