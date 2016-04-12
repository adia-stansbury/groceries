class ChangeNdbnoToString < ActiveRecord::Migration
  def change
    remove_column :ingredients, :ndbno, :integer
    add_column :ingredients, :ndbno, :string
  end
end
