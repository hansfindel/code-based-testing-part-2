class AddSecondaryEffectToWeapon < ActiveRecord::Migration
  def change
    add_column :weapons, :secondary_effect, :string
  end
end
