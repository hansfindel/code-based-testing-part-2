class ChangeWeaponFreezeColumnName < ActiveRecord::Migration
  def change
    rename_column :weapons, :freeze, :can_freeze
  end
end
