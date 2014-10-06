class AddCreateWeaponHabilityToCodeName < ActiveRecord::Migration
  def change
    add_column :code_names, :can_create_weapon, :boolean
  end
end
