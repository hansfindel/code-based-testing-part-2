class AddCanFreezeToWeapon < ActiveRecord::Migration
  def change
    add_column :weapons, :can_freeze, :bool, :default => false
  end
end
