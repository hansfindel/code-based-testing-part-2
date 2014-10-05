class AddCanFreezeToWeapon < ActiveRecord::Migration
  def change
    add_column :weapons, :can_freeze, :boolean, :default => false
  end
end
