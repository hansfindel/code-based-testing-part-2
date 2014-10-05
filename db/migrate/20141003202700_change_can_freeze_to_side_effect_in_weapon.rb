class ChangeCanFreezeToSideEffectInWeapon < ActiveRecord::Migration
  def change
    remove_column :weapons, :can_freeze
    add_column :weapons, :side_effect, :string
  end
end
