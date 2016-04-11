class AddColumnNdbnoToIng < ActiveRecord::Migration
  def change
    add_column :ingredients, :ndbno, :integer
  end
end
