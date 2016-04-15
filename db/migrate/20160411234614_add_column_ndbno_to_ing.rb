class AddColumnNdbnoToIng < ActiveRecord::Migration
  def change
    add_column :ingredients, :ndbno, :string
  end
end
