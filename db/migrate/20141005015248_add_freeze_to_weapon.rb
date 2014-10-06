class AddFreezeToWeapon < ActiveRecord::Migration
  def change
    add_column :weapons, :freezer, :boolean
  end
end
