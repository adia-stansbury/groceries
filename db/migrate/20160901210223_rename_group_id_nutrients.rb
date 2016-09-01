class RenameGroupIdNutrients < ActiveRecord::Migration
  def change
    rename_column :nutrients, :group_id, :nutrient_group_id
  end
end
