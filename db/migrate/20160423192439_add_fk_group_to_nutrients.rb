class AddFkGroupToNutrients < ActiveRecord::Migration
  def change
    add_column :nutrients, :group_id, :integer
  end
end
