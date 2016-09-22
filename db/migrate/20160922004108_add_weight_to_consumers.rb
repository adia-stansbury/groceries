class AddWeightToConsumers < ActiveRecord::Migration
  def change
    add_column :consumers, :weight_in_lbs, :integer
  end
end
