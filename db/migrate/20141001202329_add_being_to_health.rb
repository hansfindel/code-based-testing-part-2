class AddBeingToHealth < ActiveRecord::Migration
  def change
    add_column :healths, :being_id, :integer
  end
end
