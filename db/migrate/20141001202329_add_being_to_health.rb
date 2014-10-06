class AddBeingToHealth < ActiveRecord::Migration
  def change
    add_column :healths, :being_id, :integer
    add_column :healths, :being_type, :string
    add_index :healths, :being_id
    add_index :healths, :being_type
  end
end
