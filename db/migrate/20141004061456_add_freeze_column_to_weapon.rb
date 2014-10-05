class AddFreezeColumnToWeapon < ActiveRecord::Migration
  def change
    add_column :weapons, :freeze, :boolean, default: false
  end
end
