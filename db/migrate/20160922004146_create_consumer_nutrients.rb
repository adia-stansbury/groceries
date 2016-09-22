class CreateConsumerNutrients < ActiveRecord::Migration
  def change
    create_table :consumer_nutrients do |t|
    end

    add_column :consumer_nutrients, :daily_rda, :real
    add_reference :consumer_nutrients, :consumer, index: true, foreign_key: true
    add_reference :consumer_nutrients, :nutrient, index: true, foreign_key: true
  end
end
